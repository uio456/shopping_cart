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
      day_time_info(data)
      night_time_info(data)
      tomorrow_info(data)
    end

    def day_time_info(data)
      day_time_info = data.css('tbody tr')[0]
      @info[:day_time_info] = {des: day_time_info.css('th')[0].text,
                               temperature: day_time_info.css('td')[0].text,
                               probability_of_recipitation: day_time_info.css('td')[3].text}
      # puts day_time_info.css('th')[0].text # 什麼時段的資訊
      # puts day_time_info.css('td')[0].text # 溫度
      # puts day_time_info.css('td')[2].text # 舒適度描述
      # puts day_time_info.css('td')[3].text # 降雨機率
    end

    def night_time_info(data)
      night_time_info = data.css('tbody tr')[1]
      @info[:night_time_info] = {des: night_time_info.css('th')[0].text,
                               temperature: night_time_info.css('td')[0].text,
                               probability_of_recipitation: night_time_info.css('td')[3].text}
      # puts night_time_info.css('th')[0].text # 什麼時段的資訊
      # puts night_time_info.css('td')[0].text # 溫度
      # puts night_time_info.css('td')[2].text # 舒適度描述
      # puts night_time_info.css('td')[3].text # 降雨機率
    end

    def tomorrow_info(data)
      tomorrow_info = data.css('tbody tr')[2]
      @info[:tomorrow_info] = {des: tomorrow_info.css('th')[0].text,
                               temperature: tomorrow_info.css('td')[0].text,
                               probability_of_recipitation: tomorrow_info.css('td')[3].text}
      # puts tomorrow_info.css('th')[0].text # 什麼時段的資訊
      # puts tomorrow_info.css('td')[0].text # 溫度
      # puts tomorrow_info.css('td')[2].text # 舒適度描述
      # puts tomorrow_info.css('td')[3].text # 降雨機率
    end
  end

end
