class ChangeFollowerIdFollowedIdToInteger < ActiveRecord::Migration
  def change
    change_column :relationships, :followed_id, 'integer USING CAST(followed_id AS integer)'
    change_column :relationships, :follower_id, 'integer USING CAST(follower_id AS integer)'
  end
end
