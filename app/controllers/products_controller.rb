class ProductsController < ApplicationController
  include GetWeatherConcern

  def index
    get_weather
    @products = Product.avalible_products.includes(:vendor)
  end
end