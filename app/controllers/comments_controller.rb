class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      # require "pry"
      # binding.pry
      render json: {template: @comment.generate_template}
    end
  end


  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end

end