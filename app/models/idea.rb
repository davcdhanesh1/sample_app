class Idea < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content , presence: true , length: {minimum: 8,maximum: 500}
  validates :user_id , presence: true

  def self.find_ideas_followed_by_user(user)
    user_id = user.id
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = #{user_id}"
    where("user_id in (#{followed_user_ids}) or user_id = #{user_id}")
  end


end
