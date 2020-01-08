class AddColumnToPromotional < ActiveRecord::Migration[5.2]
  def change
    add_column :promotionals, :title, :string
    add_column :promotionals, :order_p, :integer
  end
end
