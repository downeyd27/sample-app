class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      status = 201
      # need to write test for flash
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      status = 400
      # need to write test for flash
      flash[:error] = "Micropost NOT created!"
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end
  # end of private methods
end