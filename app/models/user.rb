class User < ActiveRecord::Base
  has_many :documents
  has_many :events
  has_many :posts
  has_many :comments
  mount_uploader :avatar, AvatarUploader
  # after_save :enqueue_image
  has_secure_password

  def self.set_avatar_url(key)
    'https://s3-us-west-2.amazonaws.com/smustem-avatars/' + key
  end


  def self.search(search)
    name = self.prep_search(search)
    name.class == Array ? self.last_name_search(name) : self.first_name_search(name)
  end

  def self.first_name_search(f_name)
    result = self.perform_search(f_name, 'first_name')
    if result.count > 0 || f_name.length == 0
      result
    else
      f_name.chop!
      self.first_name_search(f_name)
    end

  end

  def self.check_nil_results(ary)
    ary == nil || ary.length == 0
  end

  def self.find_first_name_from_last(f_name)
    user_ary = @_last_name_array
    return 'No results' if self.check_nil_results(user_ary)
    return user_ary if user_ary.length == 1
    if user_ary.select! { |user| user.first_name.downcase == f_name } != nil
      user_ary
    else
      f_name.chop!
      self.find_first_name_from_last(f_name)
    end
  end

  def self.last_name_search(name)
    result = self.perform_search(name[1], 'last_name')
    if result.count > 0 || name[1].length == 0
      @_last_name_array = result.to_a
      self.find_first_name_from_last(name[0])
    else
      name[1].chop!
      self.last_name_search(name[1])
    end
  end

  def self.perform_search(name, search_type)
    where(["LOWER(#{search_type}) LIKE ?", "#{name}%"])
  end

  def self.prep_search(input)
    input.include?(' ') ? input.split(' ') : input
  end

  def get_home_route
    if self.admin
      "/admin/users/#{self.id}"
    else
      "/users/#{self.id}"
    end
  end

  def enqueue_image
    if self.avatar != nil
      ImageWorker.perform_async(id, key) if key.present?
    end
  end

  def avatar_name
    File.basename(avatar.path || avatar.filename) if avatar
  end

  class ImageWorker
    include Sidekiq::Worker

    def perform(id, key)
      avatar = current_user.avatar
      avatar.key = key
      avatar.remote_image_url = avatar.direct_fog_url(with_path: true)
      avatar.save!
    end
  end

end
