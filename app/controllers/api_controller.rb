class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # ref: https://stackoverflow.com/questions/27098239/post-422-unprocessable-entity-in-rails-due-to-the-routes-or-the-controller
  before_action :authenticate_user_from_token!

  # 這邊要另外見一個驗證 token 的方法，不然如果前台有登入這裡就不會再驗證 token
  # 或是說這樣也是不錯，代表他有登入了，可以通行無阻拿取 API

  def authenticate_user_from_token!
    if params[:auth_token].present?
      user = User.find_by_authentication_token(params[:auth_token])
      sign_in(user, store: false) if user
    end
  end

end
