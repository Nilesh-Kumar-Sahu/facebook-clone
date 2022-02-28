class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_user,   only: :destroy


    def show
        @user = User.find(params[:id])
        @posts = @user.posts
    end

    def index
        @users = User.paginate(page: params[:page])
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User deleted"
        redirect_to users_url
    end

    private

    # Confirms an admin user.
    def admin_user
        redirect_to(root_url) unless current_user.admin?
    end
end
