class Product < ApplicationRecord
  belongs_to :vendor
  validates_presence_of :vendor, :title, :price, :state
  validate :check_product_price

  scope :avalible_products, -> { where(state: ["vendor_p", "normal", "item_p"])}


private

  def check_product_price
    if price <= 0
      errors.add(:price, "can't not less then 0")
    end
  end

end
