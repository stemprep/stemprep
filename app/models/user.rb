class User < ActiveRecord::Base
  has_many :documents
  has_many :events
  has_many :posts
  has_many :comments
  mount_uploader :avatar, AvatarUploader
  has_secure_password




  def get_home_route
    if self.admin
      "/admin/users/#{self.id}"
    else
      "/users/#{self.id}"
    end
  end

end
