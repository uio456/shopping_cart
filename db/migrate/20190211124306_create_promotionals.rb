class CreatePromotionals < ActiveRecord::Migration[5.2]
  def change
    create_table :promotionals do |t|
      t.string :title, null: false
      t.integer :item_p, default: 3
      t.decimal :item_discount, default: 1
      t.integer :vendor_p, default: 3
      t.decimal :vendor_discount, default: 1
      t.integer :order_p, default: 1000
      t.decimal :cart_discount, default: 1
      t.integer :miximun_discount, default: 500
      t.datetime :discount_deadline

      t.timestamps
    end
  end
end
