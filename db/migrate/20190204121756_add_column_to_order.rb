class AddColumnToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :shipping_fee, :integer
  end
end
