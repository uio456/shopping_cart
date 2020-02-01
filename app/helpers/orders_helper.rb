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
    @_promotion ||= Promotional.first
    @_promotion.vendor_discount

    case product.state

    when "item_p"
      state + "，滿#{@_promotion.item_p}件#{Promotional::DISCOUNT.key(@_promotion.item_discount)}"
    when "vendor_p"
      state + "，滿#{@_promotion.vendor_p}件#{Promotional::DISCOUNT.key(@_promotion.vendor_discount)}"
    else
      state
    end
  end
end
