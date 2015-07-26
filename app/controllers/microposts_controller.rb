class MicropostsController < ApplicationController
  before_filter :signed_in_user

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

  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
  # end of private methods
end