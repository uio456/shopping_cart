class Admin::UserPolicy < ApplicationPolicy

  def update?
    user.superman?
  end

end
