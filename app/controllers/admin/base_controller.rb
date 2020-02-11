class Admin::BaseController < ApplicationController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_admin
  # before_action do
  #   authorize( pundit_scope )
  # end

  private

   def authenticate_admin
     unless current_user.admin?
       flash[:alert] = "What?"
       redirect_to root_path
     end
   end

   def pundit_scope
     [:admin, controller_name.singularize.to_sym]
   end

  def user_not_authorized
    render plain: "You are not authorized to perform this action.", status: 403
  end

end