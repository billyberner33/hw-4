class User < ApplicationRecord
  has_secure_password  # Enables built-in password encryption with BCrypt

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end