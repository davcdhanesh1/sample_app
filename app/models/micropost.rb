class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content , presence: true , length: {minimum: 8,maximum: 500}
  validates :user_id , presence: true

end
