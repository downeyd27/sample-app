class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      status = 201
      sign_in user
      flash[:success] = "Valid signin credentials.  You just signed in!"
      redirect_back_or user
    else
      status = 400
      flash.now[:error] = "Invalid email/password combination.  You were not signed in!"
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "Logged out!"
    redirect_to root_url
  end
end
