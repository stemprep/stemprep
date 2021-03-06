class ProfilesController < ApplicationController

  def show
    # @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @uploader = current_user.avatar
    @uploader.success_action_redirect = "https://morning-atoll-2439.herokuapp.com/users/#{current_user.id}/profile/update_picture"
    @user = User.find_by_id(params[:user_id])
    @is_current = current_user.id == @user.id
    render 'users/profile'
  end

  def new

  end



  def edit
    @uploader = current_user.avatar.new
    @uploader.success_action_redirect = "/users/#{current_user.id}/profile"
    render 'users/edit_profile'
  end

  def update

  end

  def destroy

  end

end