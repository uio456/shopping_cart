class Admin::ProductPolicy < ApplicationPolicy

  def update?
    user.superman? or (user.admin? && user.vendor_id == record.vendor_id)
  end

end
