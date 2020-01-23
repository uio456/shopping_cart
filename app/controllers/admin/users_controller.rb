class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = User.all_customers
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "新增管理員完成"
    else
      flash.alert = Errorhandle.call(@user)
      render :new
    end
  end

  def edit
  end

  def update
    if @user.email == "root@example.com"
      flash[:alert] = "不要亂動~"
      redirect_back(fallback_location: admin_admin_users_path)
      # render :file => "public/401.html", :status => :unauthorized
    else
      @user.update(user_params)
      if @user.role == "admin" || @user.role == "superman"
        redirect_to admin_admin_users_path, notice: "更新管理員完成"
      else
        redirect_to admin_users_path, notice: "更新使用者完成"
      end
    end
  end

  def admin
    @users = User.all_admin
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to users_path, notice: "無此使用者" unless @user
  end

  def user_params
    params.require(:user).permit(:role, :name, :email, :password)
  end

end