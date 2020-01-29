class RemoveTagCollectionFromWeatherCollects < ActiveRecord::Migration[5.2]
  def change
    remove_column :weather_collects, :tag_collection
  end
end
