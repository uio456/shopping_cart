class Product < ApplicationRecord
  belongs_to :vendor

  scope :avalible_products, -> { where(state: ["VendorP", "Normal", "ItemP"])}

end
