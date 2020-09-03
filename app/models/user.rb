# frozen_string_literal: true

class User < ApplicationRecord
  # encrypt password
  has_secure_password
  # Model associations
  has_many :projects, foreign_key: :created_by
  # Validations
  validates_presence_of :name, :email, :password_digest

  def to_admin
    update(admin: true)
  end
end
