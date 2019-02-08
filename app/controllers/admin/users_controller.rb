class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def method_name
    
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "更新成功"
    else
      redirect_to admin_users_path, notice: "怪怪的"
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to users_path, notice: "無此使用者" unless @user
  end

  def user_params
    params.require(:user).permit(:role)
  end

end