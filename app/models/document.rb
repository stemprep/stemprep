class Document < ActiveRecord::Base
  belongs_to :user
  mount_uploader :document, DocumentUploader
  def self.set_full_url(key)
    'https://s3-us-west-2.amazonaws.com/smustem-files/' + key
  end
end
