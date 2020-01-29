class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :products, through: :taggings
  belongs_to :weather_collect, optional: true
end
