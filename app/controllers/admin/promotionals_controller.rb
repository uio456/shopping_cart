class Admin::PromotionalsController < Admin::BaseController
  before_action :find_promotional, only: [:index, :edit, :update]

  def index
  end

  def new
    @promotionl = Promotional.new
  end

  def show
  end

   def create
    @promotional = Promotional.new(promotional_params)
    if @promotional.save
      redirect_to admin_promotionals_path, notice: "新增商品完成"
    else
      flash.alert = Errorhandle.call(@promotional)
      render :new
    end
  end

  def edit
  end

  def update
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
    params.permit(:title, :item_p, :item_discount, :vendor_p, :vendor_discount, :order_p, :order_discount, :maximum_discount, :discount_deadline, :shipping_fee, :discount_deadline)
  end

end