class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
    @vendors = Vendor.all
    if current_user.superman?
      @products = Product.all.includes(:tags)
    else
      @products = Product.where(vendor_id: current_user.vendor_id).includes(:tags)
    end
    @product = Product.new
  end

  def new
    @product = Product.new
    @vendor = Vendor.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "新增商品完成"
    else
      flash.alert = Errorhandle.call(@product)
      render :new
    end
  end

  def edit
  end

  def update
    authorize [:admin, @product]
    if @product.update(product_params)
      redirect_back(fallback_location: admin_products_path, notice: "商品更新成功")
    else
      redirect_back(fallback_location: admin_products_path, alert: @product.errors.full_messages.to_sentence)
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "商品已刪除"
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id])
    redirect_to products_path, notice: "無此商品" unless @product
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :vendor_id, :state, :tag_list)
  end

  

end
