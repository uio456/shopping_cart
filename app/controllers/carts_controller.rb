class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:id])
    # current_cart Helper 做出拿到 cart
    # @cart ||= Cart.from_hash(session[Cart::SessionKey])
    # 增加 cart 裡面的 item 數量
    if current_cart.total_price >= 800
      # 金額大於 800 送特定商品
      # 把 products.state == "ForFree" 的商品變成 0 元
      free_product = Product.where(state: "ForFree").sample
      free_product.price = 0
      free_product.save
      current_cart.add_item(free_product.id)
    end
    session[Cart::SessionKey] = current_cart.serialize
    # 最後存進 session 裡

    redirect_to products_path, notice: "已加入購物車"
  end

  def show
    @order = Order.new
    # new 一個 order 物件讓使用者填寫 name address phone
    # @cart = current_cart.check_discount(current_cart)
    # @filter_cart = DiscountCart.new(current_cart).perform
    # binding.pry
  end

  def destroy
    session[Cart::SessionKey] = nil
    redirect_to products_path, notice: "購物車已清空"
  end
end