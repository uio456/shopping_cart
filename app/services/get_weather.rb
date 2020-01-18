require 'nokogiri'
require 'open-uri'
class GetWeather

  class << self
    def perform
      @info = Hash.new
      books = Nokogiri::HTML(open('https://www.cwb.gov.tw/V7/forecast/taiwan/Taipei_City.htm'))
      data = books.css('.FcstBoxTable01').first
      city = data.css('thead th').first.content
      @info[:city] = city

      get_info(data)
      @info
    end

    def get_info(data)
      puts "======="
      day_time_info(data)
      puts "======="
      night_time_info(data)
      puts "======="
      tomorrow_info(data)
    end

    def day_time_info(data)
      day_time_info = data.css('tbody tr')[0]
      # puts day_time_info.css('th')[0].text # 什麼時段的資訊
      # puts day_time_info.css('td')[0].text # 溫度
      # puts day_time_info.css('td')[2].text # 舒適度描述
      # puts day_time_info.css('td')[3].text # 降雨機率
    end

    def night_time_info(data)
      night_time_info = data.css('tbody tr')[1]
      # puts night_time_info.css('th')[0].text # 什麼時段的資訊
      # puts night_time_info.css('td')[0].text # 溫度
      # puts night_time_info.css('td')[2].text # 舒適度描述
      # puts night_time_info.css('td')[3].text # 降雨機率
    end

    def tomorrow_info(data)
      tomorrow_info = data.css('tbody tr')[2]
      # puts tomorrow_info.css('th')[0].text # 什麼時段的資訊
      # puts tomorrow_info.css('td')[0].text # 溫度
      # puts tomorrow_info.css('td')[2].text # 舒適度描述
      # puts tomorrow_info.css('td')[3].text # 降雨機率
    end
  end

end
