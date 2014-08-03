class RelationshipsController < ApplicationController

  before_action :signed_in_user, only: [:create,:destroy]

  def create
    @user_to_be_followed = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user_to_be_followed)
    redirect_to current_user
  end

  def destroy
    @relationship_to_be_destroyed = current_user.relationships.find_by(params[:id])
    @relationship_to_be_destroyed.destroy!
    redirect_to current_user
  end

end