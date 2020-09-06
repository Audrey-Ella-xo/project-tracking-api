require 'acceptance_helper'

resource 'Project', acceptance: true do
  let!(:user) { create(:user) }
  let!(:projects) { create_list(:project, 10, created_by: user.id) }
  #   let(:project_id) { projects.first.id }
  before do
    header 'Content-Type', 'application/json'
    header 'Authorization', token_generator(user.id)
    user.to_admin
  end

  get 'projects' do
    example_request 'Listing projects' do
      explanation 'List all the projects in the system no authentication is needed'
      expect(status).to eq 200
    end
  end

  get 'projects/:id' do
    route_summary 'This is used to display info from an specific project.'

    let(:id) { projects.first.id }
    example_request 'Getting a specific project' do
      explanation 'Shows a specific project no authentication is needed'
      expect(status).to eq(200)
    end
  end

  post 'projects' do
    route_summary 'This is used to create projects.'

    parameter :name, 'Project name'
    parameter :description, 'Project description'
    parameter :created_by, 'Admin User id'

    example_request 'Creating a new project' do
      explanation 'Creates a new project requires an admin user to be logged in'
      do_request(name: 'Squats', description: 'Squating', created_by: user.id.to_s)
      expect(status).to eq(201)
    end
  end

  put 'projects/:id' do
    route_summary 'This is used to update projects.'
    let(:id) { projects.first.id }

    parameter :name, 'Project name'
    parameter :created_by, 'Admin User id'
    parameter :description, 'Project description'

    example_request 'Updating an specific project' do
      explanation 'Updates a new project requires an admin user to be logged in'
      do_request(name: 'Push-ups', description: 'Pushing up', created_by: user.id.to_s)
      expect(status).to eq(204)
    end
  end
end
