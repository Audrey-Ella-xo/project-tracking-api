# frozen_string_literal: true

class Todo < ApplicationRecord
  belongs_to :project

  # model association
  has_many :items, dependent: :destroy

  # validations
  validates_presence_of :title
  validates_presence_of :progress
end
