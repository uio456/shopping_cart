class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items


  def add_order_items(current_cart)
    current_cart.items.each do |cart_item|
      self.order_items.build(
        product_id: cart_item.product.id,
        quantity: cart_item.quantity, 
        price: cart_item.price
      )
    end
  end

end
