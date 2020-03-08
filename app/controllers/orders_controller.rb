class OrdersController < ApplicationController
  before_action :require_login

  def index
    @orders = current_user.orders
  end

  def create
    @order = Order.new(sn: Time.new.to_i, amount: current_cart.total_price, shipping_fee: current_cart.shipping_fee, user_id: current_user.id)
    @order.add_order_item(current_cart)
    if @order.save
      session[Cart::SessionKey] = nil
      redirect_to orders_path, notice: "new order created"
    else
      redirect_to cart_path, notice: "something went worn"
    end
  end

  private

  def require_login
    unless current_user.present?
      redirect_to new_user_session_path, alert: "Please, Login to Create Order, many Thans : )"
    end
  end

end
