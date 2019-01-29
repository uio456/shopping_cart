class ApplicationController < ActionController::Base
  before_action :init_cart

  private
  def init_cart
    @cart = Cart.from_hash(session[:cart9487])
  end
end
