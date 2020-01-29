class Admin::WeatherCollectsController < Admin::BaseController
  before_action :find_weather_collect

  def index
    find_weather_collect
    @weather_collects = WeatherCollect.all
    @tags = Tag.all
  end

  def edit
  end

  def update
    if @weather_collect.update(weather_collect_params)
      redirect_back(fallback_location: admin_weather_collects_path, notice: "更新成功")
    else
      redirect_back(fallback_location: admin_weather_collects_path, alert: @weather_collect.errors.full_messages.to_sentence)
    end
  end
  
  private

  def find_weather_collect
    @weather_collect = if params[:id]
                         WeatherCollect.find(params[:id])
                       else
                         WeatherCollect.new
                       end
  end

  def weather_collect_params
    params.require(:weather_collect).permit(:name, :tag_collection)
  end

end