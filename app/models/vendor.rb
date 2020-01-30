class Vendor < ApplicationRecord
  has_many :products
  has_many :vendor_staffs
end
