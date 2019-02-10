class Product < ApplicationRecord
  belongs_to :vendor
  validates_presence_of :vendor, :title, :price, :state
  validate :check_product_price

  scope :avalible_products, -> { where(state: ["VendorP", "Normal", "ItemP"])}


private

  def check_product_price
    if state == "Normal" || state == "Admin" || state == "SuperAdmin"
      if price <= 0
        errors.add(:price, "can't not less then 0")
      end
    end
  end

end
