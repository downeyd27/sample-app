class UsersController < ApplicationController

  include ApplicationHelper

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,   only: [:destroy]

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    if signed_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    if signed_in?
      redirect_to root_url
    else
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
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      status = 200
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
    if current_user.admin == true
      if User.find(params[:id]).destroy
        status = 200
        # Need to write tests
        flash[:success] = "User deleted"
        redirect_to users_url
      else
        status = 400
        # Need to write tests
        flash[:error] = "User was NOT deleted"
        redirect_to users_url
      end
    else
      redirect_to root_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
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
