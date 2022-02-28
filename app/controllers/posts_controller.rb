class PostsController < ApplicationController
  before_action :authenticate_user! , only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])

    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to root_url
    else
      @feed_items = current_user.feed
      render 'static_pages/home'
    end
  end

  def destroy
    @post.delete
    flash[:success] = 'Post deleted successfully'
    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

end
