module GetWeatherConcern
  extend ActiveSupport::Concern

  def get_weather
    if params[:city] != nil
      @weather_info = GetWeather.perform(city: params[:city], which_day: params[:which_day])
    end
  end
end