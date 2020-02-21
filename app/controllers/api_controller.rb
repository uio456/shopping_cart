class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # ref: https://stackoverflow.com/questions/27098239/post-422-unprocessable-entity-in-rails-due-to-the-routes-or-the-controller
  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!
    if params[:auth_token].present?
      user = User.find_by_authentication_token(params[:auth_token])
      sign_in(user, store: false) if user
    end
  end

end
