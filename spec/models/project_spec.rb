require 'rails_helper'

RSpec.describe Project, type: :model do
# Association test
  # ensure Todo model has a 1:m relationship with the Project model
  it { should have_many(:todos).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end
