class UsersController < ApplicationController
  include ApplicationHelper

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      status = 201
      sign_in @user
      # may need to make test for checking if flash success occurs
      flash[:success] = "Welcome to #{base_title} App!"
      redirect_to @user
    else
      status = 400
      # may need to make test for checking if flash error occurs
      flash[:error] = "Invalid credentials for creating an account!"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      status = 201
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      status = 400
      # flash[:error] = "Invalid user update submission "write tests before uncommenting.
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  # End of private methods.
end
