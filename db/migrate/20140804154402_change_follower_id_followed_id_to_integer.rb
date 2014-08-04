class ChangeFollowerIdFollowedIdToInteger < ActiveRecord::Migration
  def change
    change_column :relationships, :followed_id, :integer
    change_column :relationships, :follower_id, :integer
  end
end
