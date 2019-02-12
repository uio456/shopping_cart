class Admin::PromotionalsController < Admin::BaseController

  def index
    @promotional = Promotional.first
    @update_promotionl = Promotional.new
    @user = User.first
  end

  def show
  end

  def edit
    @promotional = Promotional.first
  end

  def update
      @promotional = Promotional.first
    if @promotional.update(promotional_params)
      redirect_back(fallback_location: admin_promotionals_path, notice: "更新成功")
    else
      redirect_back(fallback_location: admin_promotionals_path, alert: @promotional.errors.full_messages.to_sentence)
    end
  end

  private

  def find_promotional
    @promotional = Promotional.first
  end

  def promotional_params
    params.permit(:cart_item_discount, :cart_discount, :item_p, :vendor_p, :order_discount, :miximun_discount, :discount_deadline)
  end

end