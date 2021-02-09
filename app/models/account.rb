# frozen_string_literal: true

# Account
class Account < ApplicationRecord
  include JWT::Authenticatable

  has_secure_password

  has_many :tasks

  validates :username, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true,  format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
end
