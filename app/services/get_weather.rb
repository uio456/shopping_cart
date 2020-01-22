require 'nokogiri'
require 'open-uri'
class GetWeather

  class << self
    def perform(city: "Taipei_City")
      @info = Hash.new
      @city = city

      get_info
      @info
    end

    def get_info
      if I18n.t('get_weather.en').values.include?(@city)
        data = connect_url

        today_info(data)
        tonight_info(data)
        tomorrow_info(data)
      else
        @info
      end
    end

    def connect_url
      url = "https://www.cwb.gov.tw/V7/forecast/taiwan/#{@city}.htm"
      books = Nokogiri::HTML(open(url))
      # 舊網站支援到 2020/1/31 ？ 新網站地址 https://www.cwb.gov.tw/V8/C/W/County/County.html?CID=63
      data = books.css('.FcstBoxTable01').first
      # 這邊都要確認，如果資料是 nill 就直接回傳沒有資料
      city = data.css('thead th').first.content
      @info[:query_time] = Time.current.strftime('%Y-%m-%d %H:%M:%S')
      @info[:url] = url
      @info[:city] = city

      data
    end

    def today_info(data)
      day_time_info = data.css('tbody tr')[0]
      @info[:today_info] = {time_info: day_time_info.css('th')[0].text, # 什麼時段的資訊
                               temperature: day_time_info.css('td')[0].text, # 溫度
                               desc: day_time_info.css('td')[2].text, # 舒適度描述
                               probability_of_recipitation: day_time_info.css('td')[3].text # 降雨機率
                              }
    end

    def tonight_info(data)
      night_time_info = data.css('tbody tr')[1]
      @info[:tonight_info] = {time_info: night_time_info.css('th')[0].text,
                                 temperature: night_time_info.css('td')[0].text,
                                 desc: night_time_info.css('td')[2].text,
                                 probability_of_recipitation: night_time_info.css('td')[3].text
                                }

    end

    def tomorrow_info(data)
      tomorrow_info = data.css('tbody tr')[2]
      @info[:tomorrow_info] = {time_info: tomorrow_info.css('th')[0].text,
                               temperature: tomorrow_info.css('td')[0].text,
                               desc: tomorrow_info.css('td')[2].text,
                               probability_of_recipitation: tomorrow_info.css('td')[3].text
                              }
    end

  end

end
