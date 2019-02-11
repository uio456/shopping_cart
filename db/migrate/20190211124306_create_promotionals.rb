class CreatePromotionals < ActiveRecord::Migration[5.2]
  def change
    create_table :promotionals do |t|
      t.float :cart_item_discount, default: 1
      t.float :cart_discount, default: 1
      t.integer :item_p, default: 3
      t.integer :vendor_p, default: 3
      t.integer :order_discount, default: 1000
      t.integer :miximun_discount, default: 500
      t.datetime :discount_deadline

      t.timestamps
    end
  end
end
