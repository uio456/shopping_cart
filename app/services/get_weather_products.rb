class GetWeatherProducts
  class << self

    def perform(products, weather_info)
      @products = products
      @weather_info = weather_info

      @products = find_fit_products
    end

    def find_fit_products

      # 這邊應該要用 join 來拉資料
      # @weather_info 拿資料
      # @weather_info[:day_time_info][:desc]
      
      product_ids = Tagging.where(tag_id: Tag.where(name: "帶入天氣").select(:id)).select(:product_id)
      @products.where(id: product_ids)

    end

  end
end