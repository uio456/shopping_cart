class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items


  def add_order_items(current_cart)
    current_cart.items.each do |cart_item|
      self.order_items.build(
        product_id: cart_item.product.id,
        quantity: cart_item.quantity, 
        price: cart_item.product.price
        # price: cart_item.product.price
        # 可在新增每個 product 的價錢，讓 order_item 顯示單個 product 價錢
      )
    end
  end

end
