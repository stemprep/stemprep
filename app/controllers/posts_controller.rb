class PostsController < ApplicationController

  def show
    @post = Post.find_by_id(params[:id])
    render 'posts/show', :layout => false
  end

end