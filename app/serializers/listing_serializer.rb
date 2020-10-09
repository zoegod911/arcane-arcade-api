class ListingSerializer
  include FastJsonapi::ObjectSerializer

  attribute :id do |object|
    object.id.to_s
  end

  attribute :description do |object|
    object.description.to_s
  end

  attribute :supported_platforms do |object|
    object.supported_platforms.map(&:id)
  end

  attributes    :title, :slug, :price, :preorderable,
                :early_access, :esrb, :images, :videos,
                :currency_symbol, :default_currency,
                :btc_amount, :xmr_amount, :accepts_bitcoin, :accepts_monero,
                :status


  belongs_to :seller, serializer: SellerSerializer
  has_many :supported_platform_listings, serializer: SupportedPlatformListingSerializer
end
