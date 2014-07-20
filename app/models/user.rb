class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:name, { presence: true, length: { maximum: 32, minimum: 8 } })
  validates(:email, { presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: true } })
  before_save { self.email = email.downcase }
  has_secure_password
end
