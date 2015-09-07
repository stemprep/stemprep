class ForumController < ApplicationController

  def show
    @posts = Post.all.order(created_at: :desc)
    @new_post = current_user.posts.new
    render 'forum/index'
  end

end