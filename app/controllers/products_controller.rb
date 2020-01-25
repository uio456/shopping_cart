class ProductsController < ApplicationController
  include GetWeatherConcern

  def index
    get_weather
    @products = FilterProducts.perform(@weather_info)
  end

  def favorite
    product = Product.find(params[:id])
    product.favorites.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    product = Product.find(params[:id])
    favorites = Favorite.where(product: product, user: current_user, cancel_at: nil)
    favorites.update_all(cancel_at: Time.current)
    redirect_back(fallback_location: root_path)
  end

end