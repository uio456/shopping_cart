class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = User.all_customers
  end

  def new
    @user = User.new
    # 這裡應該要傳 VendorStaff.new
  end

  def create
    if params[:vendor_id].present?
      @user = VendorStaff.new(user_params)
    else
      @user = User.new(user_params)
    end

    if @user.save
      redirect_to admin_admin_users_path, notice: "新增管理員完成"
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
    if current_user.superman?
      @users = User.where.not(role: "normal")
    elsif current_user.vendor_id.present?
      @users = VendorStaff.where(vendor_id: current_user.vendor_id)
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to users_path, notice: "無此使用者" unless @user
  end

  def user_params
    params.require(:user).permit(:role, :name, :email, :password, :vendor_id)
  end

end