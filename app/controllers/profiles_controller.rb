class ProfilesController < ApplicationController

  def show
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    render 'users/profile'
  end

  def new

  end

  def create

  end

  def edit
    render 'users/edit_profile'
  end

  def update

  end

  def destroy

  end

end