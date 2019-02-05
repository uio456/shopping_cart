class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
    @vendors = Vendor.all
    @products = Product.all
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
      # flash.alert = Handle.new(@product).call
      # flash.alert = create_fail_error_message(@product)
      flash.alert = Errorhandle.call(@product)
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "商品更新成功"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "商品已刪除"
  end

  private
  def find_product
    @product = Product.find_by(id: params[:id])
    redirect_to products_path, notice: "無此商品" unless @product
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :vendor_id, :state)
  end
end
