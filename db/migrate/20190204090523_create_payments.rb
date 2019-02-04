class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :payment_method
      t.text :params
      t.integer :sn, null: false
      t.integer :amount
      t.datetime :paid_at
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
