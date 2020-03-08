class Admin::AdminsController < Admin::BaseController

  def index
    if current_user.superman?
      @users = User.where.not(type: User.name)
    elsif current_user.vendor_id.present?
      @users = VendorStaff.where(vendor_id: current_user.vendor_id)
    end
  end

end