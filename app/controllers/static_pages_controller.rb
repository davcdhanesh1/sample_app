class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:post_new_idea]
  def post_new_idea
    @new_micropost = current_user.microposts.build if signed_in?
  end

  def help

  end

  def about

  end

  def index

  end

  def contact

  end
end
