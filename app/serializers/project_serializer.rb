class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_by, :created_at, :updated_at

  has_many :todos
end
