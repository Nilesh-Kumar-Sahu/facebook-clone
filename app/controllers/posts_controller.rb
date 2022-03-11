class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :find_user, only: %i[edit update destroy]

  def index
    # debugger
  end

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

  def edit
    @title = 'Edit Page'
  end

  def update
    # debugger
    if @post.update(post_params)
      flash[:success] = 'Post updated successfully'
      redirect_to root_url
    else
      flash[:warning] = 'Something went wrong, post not edited'
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post deleted successfully'
    if request.referrer.nil? || request.referrer == posts_url
      redirect_to root_url
    else
      redirect_to request.referrer
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def find_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
#fsgshgcdshjchjdscbdsjcdskjcndscsdjk
end
