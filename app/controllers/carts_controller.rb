class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:id])
    # current_cart 來源自，CartsHelper
    # if current_cart.total_price >= 800
    #   # 800 的金額應該寫進 Promotional 裡
    #   # 後台沒做滿額送產品的介面
    #   Discount.free_product(current_cart)
    # end
    session[Cart::SessionKey] = current_cart.serialize
    # 最後存進 session 裡

    redirect_to products_path, notice: "已加入購物車"
  end

  def show
    @order = Order.new
  end

  def destroy
    session[Cart::SessionKey] = nil
    redirect_to products_path, notice: "購物車已清空"
  end
end