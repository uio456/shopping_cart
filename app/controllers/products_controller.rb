class ProductsController < ApplicationController
  include GetWeatherConcern # 可把這個移到 service 裡

  def index
    get_weather
    @products = FilterProducts.perform(@weather_info)
  end

  def favorite
    @product = Product.find(params[:id])
    @product.favorites.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unfavorite
    @product = Product.find(params[:id])
    favorites = Favorite.where(product: @product, user: current_user)
    favorites.destroy_all
    redirect_back(fallback_location: root_path)
  end
end