class User < ApplicationRecord
  authenticates_with_sorcery!

  include TwoFactorAuth
  include ForgotPassword

  has_one :seller
  has_many :owned_games
  has_many :favorites
  has_many :notifications
  has_many :orders, foreign_key: :buyer_id

  accepts_nested_attributes_for :seller

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :phone_number, presence: true

  def owned_game?(listing_id, platform)
    pc_platforms = ["MAC", "WINDOWS", "LINUX"]
    self.orders.includes(owned_game: :supported_platform).where(
      listing_id: listing_id,
      owned_games: {
        supported_platforms: { name: pc_platforms.include?(platform) ? pc_platforms : platform }
      }
    ).any?
  end

  def own_game?(listing_id)
    self.seller && self.seller.listing_ids.include?(listing_id)
  end
end
