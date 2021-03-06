class User < ActiveRecord::Base

  has_many :ideas, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name:'Relationship', dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


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

  def feeds
    Idea.find_ideas_followed_by_user(self)
  end

  def following?(other_user)
    if relationships.find_by(followed_id: other_user.id)
      return true
    end
    return false
  end

  def follow!(other_user)
    relationships.create(followed_id: other_user.id).save
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def followed_users_ids
    followed_users.map(&:id)
  end

end
