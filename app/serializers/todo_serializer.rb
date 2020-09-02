# frozen_string_literal: true

class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :progress, :project_id, :created_at, :updated_at

  belongs_to :project
  has_many :items
end
