class MicropostsController < ApplicationController

  before_action :signed_in_user, only: [:create, :destroy]

  def destroy
    head :ok
  end


  def create

    @post_content = params[:post_content]
    @new_micropost = current_user.microposts.new(micropost_params)
    if @new_micropost.save
      flash[:success] = 'Your new idea is now live to world...'
      redirect_to current_user
    else
      render 'static_pages/home'
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end


end
