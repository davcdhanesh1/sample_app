class User < ActiveRecord::Base

  has_many :microposts, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:name, { presence: true, length: { maximum: 32, minimum: 8 } })
  validates(:email, { presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: true } })
  validates(:password, { presence: true, length: { minimum: 8, maximum: 32 } })
  before_save { self.email = email.downcase }
  before_create { self.remember_token = create_remember_token }
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
