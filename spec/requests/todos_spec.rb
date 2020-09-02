require 'rails_helper'

RSpec.describe "projects", type: :request do
# Initialize the test data
# let(:user) { create(:user) }
let!(:project) { create(:project) }
let!(:todos) { create_list(:todo, 20, project_id: project.id) }
let(:project_id) { project.id }
let(:id) { todos.first.id }
# let(:headers) { valid_headers }

# Test suite for GET /projects/:project_id/todos
describe 'GET /projects/:project_id/todos' do
  before { get "/projects/#{project_id}/todos" }

  context 'when project exists' do
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all project todos' do
      expect(json.size).to eq(20)
    end
  end

  context 'when project does not exist' do
    let(:project_id) { 0 }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

    it 'returns a not found message' do
      expect(response.body).to match(/Couldn't find Project/)
    end
  end
end

# Test suite for GET /projects/:project_id/todos/:id
describe 'GET /projects/:project_id/todos/:id' do
  before { get "/projects/#{project_id}/todos/#{id}" }

  context 'when project todo exists' do
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the todo' do
      expect(json['id']).to eq(id)
    end
  end

  context 'when project todo does not exist' do
    let(:id) { 0 }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

    it 'returns a not found message' do
      expect(response.body).to match(/Couldn't find Todo/)
    end
  end
end

# Test suite for PUT /projects/:project_id/todos
describe 'POST /projects/:project_id/todos' do
  let(:valid_attributes) { { title: 'Visit Narnia' } }

  context 'when request attributes are valid' do
    before do 
     post "/projects/#{project_id}/todos", params: valid_attributes 
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'when an invalid request' do
    before { post "/projects/#{project_id}/todos" }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a failure message' do
      expect(response.body).to match(/Validation failed: Title can't be blank/)
    end
  end
end

# Test suite for PUT /projects/:project_id/todos/:id
describe 'PUT /projects/:project_id/todos/:id' do
  let(:valid_attributes) { { title: 'Mozart' } }

  before { put "/projects/#{project_id}/todos/#{id}", params: valid_attributes }

  context 'when todo exists' do
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'updates the todo' do
      updated_todo = Todo.find(id)
      expect(updated_todo.title).to match(/Mozart/)
    end
  end

  context 'when the todo does not exist' do
    let(:id) { 0 }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

    it 'returns a not found message' do
      expect(response.body).to match(/Couldn't find Todo/)
    end
  end
end

# Test suite for DELETE /projects/:id
describe 'DELETE /projects/:id' do
  before { delete "/projects/#{project_id}/todos/#{id}" }

  it 'returns status code 204' do
    expect(response).to have_http_status(204)
  end
end
end
