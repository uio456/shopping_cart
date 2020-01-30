class Admin::VendorsController < Admin::BaseController

  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find(params[:id])
    @products = @vendor.products
    @vendors = Vendor.all
  end

  def update_state
    @vendor = Vendor.find(params[:id])
    AllVendorProductPromotion.perform(@vendor)
    redirect_back(fallback_location: admin_products_path, notice: "All #{@vendor.name} Vandor roducts state is change to ---> vendor_p!")
  end
end