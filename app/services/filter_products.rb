class FilterProducts
  class << self

    def perform(weather_info)
      @products = Product.avalible_products.includes(:vendor).includes(:tags).includes(:favorites)

      if weather_info.present?
        @products = GetWeatherProducts.perform(@products, weather_info)
      end

      @products
    end

  end
end