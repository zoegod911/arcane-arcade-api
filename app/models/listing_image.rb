class ListingImage < ApplicationRecord
  include ImageUploader::Attachment(:image, store: :store) # adds an `image` virtual attribute

  belongs_to :listing

  validates_presence_of :position
end
