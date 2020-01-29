class WeatherCollect < ApplicationRecord
  has_many :tags, dependent: :destroy
end
