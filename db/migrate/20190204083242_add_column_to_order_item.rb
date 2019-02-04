class AddColumnToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :cart_item_price, :integer
    add_column :order_items, :shipping_fee, :integer
    rename_column :order_items, :price, :item_price
  end
end
