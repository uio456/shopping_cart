class Admin::VendorsController < Admin::BaseController
  before_action :find_vendor

  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find(params[:id])
    @products = @vendor.products
    @vendors = Vendor.all
  end

  def new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      redirect_to admin_vendors_path, notice: "新增廠商完成"
    else
      flash.alert = Errorhandle.call(@vendor)
      render :new
    end
  end

  def edit
  end

  def update
    if @vendor.update(vendor_params)
      redirect_back(fallback_location: admin_vendors_path, notice: "更新成功")
    else
      redirect_back(fallback_location: admin_vendors_path, alert: @vendor.errors.full_messages.to_sentence)
    end
  end


  def update_state
    @vendor = Vendor.find(params[:id])
    AllVendorProductPromotion.perform(@vendor)
    redirect_back(fallback_location: admin_products_path, notice: "All #{@vendor.name} Vandor roducts state is change to ---> vendor_p!")
  end

  private

  def find_vendor
    @vendor = if params[:id]
                 Vendor.find(params[:id])
               else
                 Vendor.new
               end
  end

  def vendor_params
    params.require(:vendor).permit(:name)
  end


end