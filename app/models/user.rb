require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  # Encrypt password before saving
  before_save :encrypt_password

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  # Virtual password field (not stored in the database)
  attr_accessor :password

  def authenticate(plain_text_password)
    BCrypt::Password.new(self.password_digest) == plain_text_password ? self : false
  end

  private

  def encrypt_password
    if password.present?
      self.password_digest = BCrypt::Password.create(password)
    end
  end
end
