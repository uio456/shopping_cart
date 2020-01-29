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

      case @weather_info[:weather_info][:desc]
      when '稍有寒意至舒適', '寒冷至舒適'
        tag_names =  ["保暖", "輕便"]
      when '舒適'
        tag_names =  ["輕便"]
      when '稍有寒意', '寒冷', '寒冷至稍有寒意', '非常寒冷至寒冷', '非常寒冷至稍有寒意'
        tag_names =  ["保暖", "防寒"]
      else
        tag_names = []
      end

      if @weather_info[:weather_info][:probability_of_recipitation].to_i > 40 # 大於 40 下雨機率
        tag_names += ["下雨"]
      end

      # 在這裡決定拿哪一個 product_collect 出來撈資料
      # product_collect 暫定四種 1.熱天 2.涼天 3.冷天 4.下雨天
      # 裡面有一個 array 存各個天氣的關鍵字
      # 只有 superman 可以更改

      product_ids = Tagging.where(tag_id: Tag.where(name: tag_names).select(:id)).select(:product_id)

      @products.where(id: product_ids)

    end

  end
end