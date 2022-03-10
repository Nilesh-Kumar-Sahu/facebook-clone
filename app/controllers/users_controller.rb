class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: :destroy


  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @friends = @user.friends
  end

  def index
    @users = User.search(params[:search]).paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def friends
    @title = 'Friends'
    @user = User.find(params[:id])
    @friends = @user.friends.paginate(page: params[:page])
    render 'show_friends'
  end

    private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
