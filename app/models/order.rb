class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  def add_order_item(current_cart)
    current_cart.items.each do |cart_item|
      self.order_items.build(
        product_id: cart_item.product.id,
        quantity: cart_item.quantity, 
        item_price: cart_item.product.price,
        cart_item_price: cart_item.price,
        shipping_fee: current_cart.shipping_fee
      )
    end
  end

end
