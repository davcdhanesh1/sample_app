class ChangeIntegerLengthSizeRemoveIntegerColumnFromMicroposts < ActiveRecord::Migration
  def change
    remove_column :relationships, :integer
    change_column :relationships, :follower_id, :integer
    change_column :relationships, :followed_id, :integer
  end
end
