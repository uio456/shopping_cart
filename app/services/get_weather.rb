require 'nokogiri'
require 'open-uri'
class GetWeather

  class << self
    def get
      books = Nokogiri::HTML(open('https://www.cwb.gov.tw/V7/forecast/taiwan/Taipei_City.htm'))
      
      data = books.css('.FcstBoxTable01').first
      city = data.css('thead th').first.content
      puts city
    end

    def get_books
      books = Nokogiri::HTML(open('http://www.books.com.tw/activity/gold66_day/?loc=activity_BK_001'))
      puts books.css('.table-td h4 a')
    end
  end


end
