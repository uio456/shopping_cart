class AddWeatherCollectIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :weather_collect, foreign_key: true
  end
end
