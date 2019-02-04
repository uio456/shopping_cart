class Admin::VendorsController < Admin::BaseController
  def show
    @vendor = Vendor.find(params[:id])
    @products = @vendor.products
    @vendors = Vendor.all
  end

  def update_state
    @vendor = Vendor.find(params[:id])
    vendor_products = @vendor.products
    vendor_products.each do |p|
      p.state = "VendorP"
      p.save
    end
    redirect_to admin_products_path, notice: "All #{ @vendor.name } Vendor State is change to ---> VendorP!"
  end
end