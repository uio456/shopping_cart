module UsersHelper

  def which_vendor
    if current_user.vendor_admin?
      Vendor.where(id: current_user.vendor_id)
    else
      Vendor.all
    end
  end

  def superman_or_vendor_admin?
    current_user.superman? || current_user.vendor_admin?
  end

  def which_role(user)
    if current_user.superman?
      if user.vendor_id.present?
        User::ROLE[1..2]
      else
        User::ROLE[0..1]
      end
    else
      User::ROLE[0..1]
    end
  end
end
