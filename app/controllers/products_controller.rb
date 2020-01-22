class ProductsController < ApplicationController
  include GetWeatherConcern # 可把這個移到 service 裡

  def index
    get_weather
    @products = FilterProducts.perform(@weather_info)
  end
end