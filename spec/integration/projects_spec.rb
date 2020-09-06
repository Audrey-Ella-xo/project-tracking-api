# require 'swagger_helper'
# describe 'Project API' do
#   path '/projects' do
#     get 'List all projects' do
#       tags 'Project'
#       consumes 'application/json'

#       response '200', 'Shows all projects no authentication is needed' do
#         schema type: :object,
#                properties: {
#                  id: { type: :integer },
#                  name: { type: :string },
#                  description: { type: :string },
#                  created_by: { type: :string },
#                  created_at: { type: :string },
#                  updated_at: { type: :string }
#                },
#                required: %w[id name]

#         let(:projects) { create_list(:Project, 10) }
#         run_test!
#       end
#     end
#   end

#   path '/projects/{id}' do
#     get 'List an specific Project' do
#       tags 'Project'
#       consumes 'application/json'
#       parameter name: :id, in: :path, type: :string

#       response '200', 'Shows an specific Project no authentication is needed' do
#         schema type: :object,
#                properties: {
#                  id: { type: :integer },
#                  name: { type: :string },
#                  description: { type: :string },
#                  created_by: { type: :string },
#                  created_at: { type: :string },
#                  updated_at: { type: :string }
#                },
#                required: %w[id name]

#         let(:id) { create(:Project).id }
#         run_test!
#       end

#       response '401', 'invalid credentials' do
#         let(:id) { 'invalid' }
#         run_test!
#       end
#     end
#   end
# end
# # rubocop:enable RSpec/EmptyExampleGroup
# # rubocop:enable RSpec/DescribeClass
