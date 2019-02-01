class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :sn
      t.integer :amount
      t.string :name
      t.string :phone
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_column  :products, :category_id, :integer
    add_column  :products, :vendor_id, :integer
    add_column  :products, :state, :string
  end
end
