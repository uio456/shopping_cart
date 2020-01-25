class UsersController < ApplicationController
  def my_favorites
    @favorited_products = Product.where(id: current_user.favorites.where("cancel_at IS NULL").select(:product_id))
    # 增加 曾經加入過最愛的產品
  end
end
