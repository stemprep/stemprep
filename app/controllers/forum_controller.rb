class ForumController < ApplicationController

  def show
    @posts = Post.all.order(created_at: :desc)
    render 'forum/index'
  end

end