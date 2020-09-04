require 'acceptance_helper'

resource 'Item', acceptance: true do
    let(:user) { create(:user) }
  let!(:project) { create(:project, created_by: user.id) }
  let!(:todos) { create_list(:todo, 20, project_id: project.id) }
  let!(:todo) { todos.first }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  before do
    header 'Authorization', token_generator(project.id)
    header 'Content-Type', 'application/json'
  end

  get '/projects/:project_id/todos/:todo_id/items' do
    let(:project_id) { project.id }
    let(:todo_id) { todo.id }
    example_request 'Listing todos items' do
      explanation 'List all the items from the login user'
      expect(status).to eq 200
    end
  end

  get '/projects/:project_id/todos/:todo_id/items/:id' do
    let(:project_id) { project.id }
    let(:todo_id) { todo.id }
    let(:id) { todos.first.id }
    example_request 'Getting a specific item from the login user' do
      explanation 'Shows a specific item from the login user'
      expect(status).to eq(200)
    end
  end

  post '/projects/:project_id/todos/:todo_id/items' do
    route_summary 'This is used to create user todos.'
    let(:project_id) { project.id }
    let(:todo_id) { todo.id }

    parameter :name, 'Todo description'
    parameter :done, 'Amount of exercise done by the user'
    parameter :todo_id, 'Login User'
   
    example_request 'Creating a new user todo' do
      explanation 'Registers a new todo from the login user'
      do_request(name: 'Repetitions', done: false, todo_id: todo.id.to_s)
      expect(status).to eq(201)
    end
  end

  put '/projects/:project_id/todos/:todo_id/items/:id' do
    route_summary 'This is used to update user todos.'
    let(:project_id) { project.id }
    let(:todo_id) { todo.id }
    let(:id) { todos.first.id }

    parameter :name, 'Todo description'
    parameter :done, 'Amount of exercise done by the user'
    parameter :todo_id, 'Login User'

    example_request 'Updating an specific user todo' do
      explanation 'Edits a todo from the login user'
      do_request(name: 'Seconds', done: true, todo_id: todo.id.to_s)
      expect(status).to eq(204)
    end
  end
end