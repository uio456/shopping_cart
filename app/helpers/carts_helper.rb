module CartsHelper
  # 寫成 Helper 的話 View 可以使用，controller 也可以使用
  def current_cart
    @cart ||= Cart.from_hash(session[Cart::SessionKey])
  end

  def item_discount_price(item)
    promotion = Promotional.first
    item_quantity = item.quantity

    case item.product.state
    when "item_p"
      if item_quantity >= promotion.item_p
        return Discount.cart_item_discount_price(item.product, item_quantity)
      end
    when "vendor_p"
      if item_quantity >= promotion.vendor_p
        return Discount.cart_item_discount_price(item.product, item_quantity)
      end
    end

    return  "-"
  end

end