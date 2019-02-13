class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def method_name
    
  end

  # def update
  #   if @user.update(user_params)
  #     redirect_to admin_users_path, notice: "更新成功"
  #   else
  #     redirect_to admin_users_path, notice: "怪怪的"
  #   end
  # end

  def update
    @user = User.find(params[:id])
    if @user.email == "root@example.com"
      flash[:alert] = "不要亂動~"
      redirect_to admin_users_path
      # render :file => "public/401.html", :status => :unauthorized
    else
      @user.update(role: params[:role])
      flash[:notice] = "#{@user.name} 權限更新為 #{params[:role]}"
      redirect_to admin_users_path
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