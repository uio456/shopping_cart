class OrdersController < ApplicationController

  def index
    # @orders = current_user.orders.order(created_at: :desc)
    @orders = Order.all
    # @orders = current_user.orders
  end

  def create
    # @order = current_user.orders.new(order_params)
    # @order.sn = Time.now.to_i
    # @order.amount = current_cart.total_price
    @order = Order.new(sn: Time.new.to_i, amount: current_cart.total_price, user_id: current_user.id)
    @order.add_order_items(current_cart)
    if @order.save
      # current_cart.destroy
      # session.delete(:new_order_data)
      session[Cart::SessionKey] = nil
      redirect_to orders_path, notice: "new order created"
    else
      redirect_to cart_path, notice: "something went worn"
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone, :address)
  end
end
