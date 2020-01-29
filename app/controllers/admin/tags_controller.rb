class Admin::TagsController < Admin::BaseController
  before_action :find_tag, only: [:update, :destroy]

  def index
    @tags = Tag.all
  end

  def update
    if @tag.update(tag_params)
      redirect_back(fallback_location: admin_weather_collects_path, notice: "更新成功")
    else
      redirect_back(fallback_location: admin_weather_collects_path, alert: @tag.errors.full_messages.to_sentence)
    end
  end

  def destroy
    @tag.destroy
    redirect_to admin_weather_collects_path, notice: "標籤已刪除"
  end

  private

  def find_tag
    @tag = Tag.find_by(id: params[:id])
  end

  def tag_params
    params.permit(:weather_collect_id)
  end

end