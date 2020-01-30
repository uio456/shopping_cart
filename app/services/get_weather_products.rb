class GetWeatherProducts
  class << self

    def perform(products, weather_info)
      @products = products
      @weather_info = weather_info

      @products = find_fitting_products
    end

    def find_fitting_products
      case @weather_info[:weather_info][:desc]
      when '稍有寒意至舒適', '寒冷至舒適', '稍有寒意', '寒冷', '寒冷至稍有寒意', '非常寒冷至寒冷', '非常寒冷至稍有寒意'
        tag_names = WeatherCollect.find_by(name: WeatherCollect::WEATHER_GROUP[1]).tags.pluck(:name) # 冷天群組
      when '舒適'
        tag_names = WeatherCollect.find_by(name: WeatherCollect::WEATHER_GROUP[2]).tags.pluck(:name) # 涼爽群組
      when '防曬'
        tag_names = WeatherCollect.find_by(name: WeatherCollect::WEATHER_GROUP[0]).tags.pluck(:name) # 夏天群組
      else
        tag_names = []
      end

      # 雨天標籤，下雨機率大於 40
      if @weather_info[:weather_info][:probability_of_recipitation].to_i > 40
        tag_names += WeatherCollect.find_by(name: WeatherCollect::WEATHER_GROUP[3]).tags.pluck(:name) # 雨天群組
      end

      product_ids = Tagging.where(tag_id: Tag.where(name: tag_names).select(:id)).select(:product_id)

      @products.where(id: product_ids)
    end

  end
end