class User < ApplicationRecord
  # encrypt password
  has_secure_password
  # Model associations
  has_many :projects, foreign_key: :created_by
  # Validations
  validates_presence_of :name, :email, :password_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  def to_admin
    update(admin: true)
  end
end
