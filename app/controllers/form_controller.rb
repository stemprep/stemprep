class FormController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)
    render 'forum/index'
  end

end