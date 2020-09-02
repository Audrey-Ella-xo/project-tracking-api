# frozen_string_literal: true

class Project < ApplicationRecord
  # model association
  has_many :todos, dependent: :destroy

  # validations
  validates_presence_of :name, :created_by
end
