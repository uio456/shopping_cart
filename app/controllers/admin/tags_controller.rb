class Admin::TagsController < Admin::BaseController

  def index
    @tags = Tag.all
  end

end