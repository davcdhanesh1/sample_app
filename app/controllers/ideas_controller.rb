class IdeasController < ApplicationController

  before_action :signed_in_user, only: [:create, :destroy]

  def destroy

    @post_to_be_deleted = Idea.find(params[:id])

    if @post_to_be_deleted.user == current_user
      @post_to_be_deleted.destroy
    end
    redirect_to current_user

  end

  def create

    @post_content = params[:post_content]
    @new_idea = current_user.ideas.new(idea_params)
    if @new_idea.save
      flash[:success] = 'Your new idea is now live to world...'
      redirect_to current_user
    else
      render 'static_pages/post_new_idea'
    end

  end

  private

  def idea_params
    params.require(:idea).permit(:content)
  end


end
