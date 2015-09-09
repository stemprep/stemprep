class PostsController < ApplicationController


  def show
    @new_post = current_user.posts.new
    if is_ajax?
      @post = Post.find_by_id(params[:id])
      render 'posts/show', :layout => false
    else
      @posts = Post.all.order(created_at: :desc)
      render 'forum/index'
    end

  end


  def create
    new_post = current_user.posts.new(post_params)
    if new_post.save
      redirect_to forum_path
    end
  end



  private

  def is_ajax?
    params[:ajax] == "true"
  end

  def post_params
    params.require(:post).permit(:user_id, :title, :body)
  end

end