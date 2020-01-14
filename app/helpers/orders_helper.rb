module OrdersHelper

  def cart_item_discount_price
    price = current_cart.cart_item_discount_price
    if price == 0
      content = "你還沒買！趕快買"
    else
      content = price
    end
     "顯示目前享有折扣金額：#{content}"
  end
end
