module UsersHelper

  def which_vendor(id)
    id.present? ? Vendor.find(id).name : "自家管理員"
  end

  def superman_or_vendor_admin?
    current_user.superman? || current_user.vendor_admin?
  end

  def which_role(user)
    if current_user.superman?
      if user.vendor_id.present?
        User::ROLE[1..2]
      else
        User::ROLE[0..2]
      end
    else
      User::ROLE[0..1]
    end
  end
end
