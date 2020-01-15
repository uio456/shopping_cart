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

  def product_state(product)
    state = I18n.t("promotion.#{product.state}")
    promotion = Promotional.first
    promotion.vendor_discount

    case product.state

    when "item_p"
      state + "，滿#{promotion.item_p}件#{Promotional::DISCOUNT.key(promotion.item_discount)}"
    when "vendor_p"
      state + "，滿#{promotion.vendor_p}件#{Promotional::DISCOUNT.key(promotion.vendor_discount)}"
    else
      state
    end
  end
end
