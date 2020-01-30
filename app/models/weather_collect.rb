class WeatherCollect < ApplicationRecord
  has_many :tags, dependent: :destroy

  WEATHER_GROUP = ['夏天群組', '冷天群組', '涼爽群組', '雨天群組' ]
end
