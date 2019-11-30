module CartsHelper
  # 寫成 Helper 的話 View 可以使用，controller 也可以使用
  def current_cart
    @cart ||= Cart.from_hash(session[Cart::SessionKey])
  end

  def product_state(p)
    # 把 item_p 轉成中文，也可以用i18n
  end
end