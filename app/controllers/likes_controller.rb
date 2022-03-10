class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(like_params)
    # debugger
    if !@like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: posts_url)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: posts_url)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
