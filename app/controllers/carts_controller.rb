class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:id])
    # current_cart Helper 做出拿到 cart
    # @cart ||= Cart.from_hash(session[Cart::SessionKey])
    # 增加 cart 裡面的 item 數量
    session[Cart::SessionKey] = current_cart.serialize
    # 最後存進 session 裡

    redirect_to products_path, notice: "已加入購物車"
  end

  def show
    @order = Order.new
    # new 一個 order 物件讓使用者填寫 name address phone
  end

  def destroy
    session[Cart::SessionKey] = nil
    redirect_to products_path, notice: "購物車已清空"
  end
end