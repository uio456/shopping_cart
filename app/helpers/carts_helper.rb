module CartsHelper
  # 寫成 Helper 的話 View 可以使用，controller 也可以使用
  def current_cart
    @cart ||= Cart.from_hash(session[Cart::SessionKey])
  end

end