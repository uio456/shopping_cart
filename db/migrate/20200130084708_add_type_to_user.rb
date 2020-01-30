class AddTypeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :type, :string
    add_reference :users, :vendor, foreign_key: true
  end
end
