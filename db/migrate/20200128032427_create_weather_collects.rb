class CreateWeatherCollects < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_collects do |t|
      t.string :name, null: false
      t.string :tag_collection

      t.timestamps
    end
  end
end
