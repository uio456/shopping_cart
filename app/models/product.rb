class Product < ApplicationRecord
  belongs_to :vendor
  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :vendor, :title, :price, :state
  validate :check_product_price

  scope :avalible_products, -> { where(state: ["vendor_p", "normal", "item_p"])}
  enum state: {vendor_p: "vendor_p", normal: "normal", item_p: "item_p", for_free: "for_free"}

private

  def check_product_price
    if price <= 0
      errors.add(:price, "can't not less then 0")
    end
  end

end
