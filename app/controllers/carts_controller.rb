class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:id])
    # current_cart 來源自，CartsHelper
    # @cart ||= Cart.from_hash(session[Cart::SessionKey])
    if current_cart.total_price >= 800
      Discount.free_product(current_cart)
    end
    session[Cart::SessionKey] = current_cart.serialize
    # 最後存進 session 裡

    redirect_to products_path, notice: "已加入購物車"
  end

  def show
    @order = Order.new
    # @cart = current_cart.check_discount(current_cart)
    # @filter_cart = DiscountCart.new(current_cart).perform
  end

  def destroy
    session[Cart::SessionKey] = nil
    redirect_to products_path, notice: "購物車已清空"
  end
end