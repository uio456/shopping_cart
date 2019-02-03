class Admin::VendorsController < Admin::BaseController
  def show
    @vendor = Vendor.find(params[:id])
    @products = @vendor.products
    @vendors = Vendor.all
  end
end