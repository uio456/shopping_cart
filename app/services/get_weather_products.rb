class GetWeatherProducts
  class << self

    def perform(products, weather_info)
      @products = products
      @weather_info = weather_info

      @products = find_fitting_products
    end

    def find_fitting_products

      # 這邊應該要用 join 來拉資料
      # @weather_info 拿資料
      # freezing
      # cold = Tag.find(11)
      # Breeze = Tag.find(12)
      # Hot = Tag.find(13)
      # rain = Tag.find(14)
      case @weather_info[:today_info][:desc]
      when '稍有寒意至舒適', '寒冷至舒適'
        tag_names =  ["保暖", "輕便"]
      when '舒適'
        tag_names =  ["輕便"]
      when '稍有寒意'
        tag_names =  ["保暖", "防寒"]
      else
        tag_names = []
      end

      product_ids = Tagging.where(tag_id: Tag.where(name: tag_names).select(:id)).select(:product_id)

      @products.where(id: product_ids)

    end

  end
end