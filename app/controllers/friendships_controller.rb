class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_if_friendship, only: %i[destroy update]

  def create
    friendship = current_user.friendships.build(friendship_params.merge(confirmed: false))
    friendship.save
    # debugger
    flash[:success] = 'Friend request sent'

    respond_to do |format|
      format.html { redirect_to request.referer || root_path }
      format.js
    end
  end

  def update
    @friendship.confirm_friendship

    flash[:success] = 'Friend request accepted successfully!'
    redirect_to request.referer || root_path
  end

  def pending
    @pending = current_user.pending_friends
  end

  def destroy
    @friendship&.destroying_friendship
    redirect_to request.referer || root_path
  end

  private

  def find_if_friendship
    @friendship = Friendship.find_by(id: params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
