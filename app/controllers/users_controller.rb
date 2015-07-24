class UsersController < ApplicationController
  include ApplicationHelper
  before_filter :signed_in_user, only: [:index, :edit, :update, :delete]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,   only: [:delete]

  def index
    @users = User.paginate(page: params[:page])
  end

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
    if @user.update_attributes(user_params)
      status = 201
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      status = 400
      # need to write tests
      flash[:error] = "Invalid user update submission"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    # Need to write tests
    flash[:success] = "user destroyed."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  # End of private methods.
end
