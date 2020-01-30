module UsersHelper

  def which_vendor
    if current_user.vendor_staff?
      Vendor.where(id: current_user.vendor_id)
    else
      Vendor.all
    end
  end
end
