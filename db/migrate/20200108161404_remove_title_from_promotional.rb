class RemoveTitleFromPromotional < ActiveRecord::Migration[5.2]
  def change
    remove_column :promotionals, :title
  end
end
