class ProductsController < ApplicationController

  def index
    @products = Product.avalible_products.includes(:vendor)
    @weather_info = GetWeather.perform
    binding.pry
  end
end