require 'acceptance_helper'

resource 'Todo', acceptance: true do
    let(:user) { create(:user) }
  let!(:project) { create(:project, created_by: user.id) }
  let!(:todos) { create_list(:todo, 20, project_id: project.id) }
  before do
    header 'Authorization', token_generator(project.id)
    header 'Content-Type', 'application/json'
  end

  get '/projects/:project_id/todos' do
    let(:project_id) { project.id }
    example_request 'Listing todos' do
      explanation 'List all the todos from the login user'
      expect(status).to eq 200
    end
  end

  get '/projects/:project_id/todos/:id' do
    let(:project_id) { project.id }
    let(:id) { todos.first.id }
    example_request 'Getting a specific todo from the login user' do
      explanation 'Shows a specific todo from the login user'
      expect(status).to eq(200)
    end
  end

  post '/projects/:project_id/todos' do
    route_summary 'This is used to create user todos.'
    let(:project_id) { project.id }

    parameter :title, 'Todo description'
    parameter :progress, 'Amount of exercise done by the user'
    parameter :project_id, 'Login User'
   
    example_request 'Creating a new user todo' do
      explanation 'Registers a new todo from the login user'
      do_request(title: 'Repetitions', progress: 12, project_id: project.id.to_s)
      expect(status).to eq(201)
    end
  end

  put '/projects/:project_id/todos/:id' do
    route_summary 'This is used to update user todos.'
    let(:project_id) { project.id }
    let(:id) { todos.first.id }

    parameter :title, 'Todo description'
    parameter :progress, 'Amount of exercise done by the user'
    parameter :project_id, 'Login User'

    example_request 'Updating an specific user todo' do
      explanation 'Edits a todo from the login user'
      do_request(title: 'Seconds', progress: 60, project_id: project.id.to_s)
      expect(status).to eq(204)
    end
  end
end
