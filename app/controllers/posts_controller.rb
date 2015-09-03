class PostsController < ApplicationController


  def show
    if is_ajax?
      @post = Post.find_by_id(params[:id])
      render 'posts/show', :layout => false
    else
      @posts = Post.all.order(created_at: :desc)
      render 'forum/index'
    end

  end



  private

  def is_ajax?
    params[:ajax] == "true"
  end

end