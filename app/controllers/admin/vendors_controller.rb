class Admin::VendorsController < Admin::BaseController
  def show
    @vendor = Vendor.find(params[:id])
    @products = @vendor.products
  end
end