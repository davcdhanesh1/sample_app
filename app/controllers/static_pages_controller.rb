class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:post_new_idea]
  def post_new_idea
    @new_idea = current_user.ideas.build if signed_in?
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
