class MicropostsController < ApplicationController

  before_action :signed_in_user, only: [:create, :destroy]

  def destroy

    @post_to_be_deleted = Micropost.find(params[:id])

    if @post_to_be_deleted.user == current_user
      @post_to_be_deleted.destroy
    end
    redirect_to current_user

  end

  def create

    @post_content = params[:post_content]
    @new_micropost = current_user.microposts.new(micropost_params)
    if @new_micropost.save
      flash[:success] = 'Your new idea is now live to world...'
      redirect_to current_user
    else
      render 'static_pages/post_new_idea'
    end

  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end


end
