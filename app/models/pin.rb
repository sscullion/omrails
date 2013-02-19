require 'open-uri'

class Pin < ActiveRecord::Base
  attr_accessible :description, :image, :image_remote_url

  before_validation :download_remote_image, :if => :image_url_provided?
  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'

  validates :description, presence: true
  validates :user_id, presence: true
  validates_attachment :image, presence: true, content_type: { 
  	content_type: ['image/jpeg', 'image/jpg', 'image/png']
  	}, size: { less_than: 5.megabytes }

  belongs_to :user
  has_attached_file :image, styles: { 
  	thumb: "100x100",
  	small: "160x120",
  	medium: "320x240>",
  	large: "640x480"
  }

  
  private
  
  def image_url_provided?
    !self.image_remote_url.blank?
  end
  
  def download_remote_image
    self.image = do_download_remote_image
    self.image_remote_url = image_remote_url
  end
  
  def do_download_remote_image
    io = open(URI.parse(image_remote_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end
  
end
