class Category < ApplicationRecord
  has_many :category_listings
  has_many :listings,  through: :category_listings

end
