class Image
  include Mongoid::Document

  embedded_in :site
  
  mount_uploader :file, ImageUploader

  attr_accessible :file, :file_cache
end
