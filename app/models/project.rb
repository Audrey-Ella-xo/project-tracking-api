class Project < ApplicationRecord
  # model association
  # belongs_to :user
  has_many :todos, dependent: :destroy

  # validations
  validates_presence_of :name, :created_by
end
