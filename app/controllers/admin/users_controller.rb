class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = User.all_customers
  end

  def new
    @user = User.new
  end

  def create
    # 考慮把 admin 也加入一個 vendor_id，這樣比較一致
    # 使用者在頁面註冊不會跑這裡
    @user_identify = :user
    if params[:user][:vendor_id].present?
      @user = VendorStaff.new(user_params)
    else
      @user = AdminStaff.new(user_params)
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
    end

    case @user.class.name
    when User.name
      @user_identify = :user
    when VendorStaff.name
      @user_identify = :vendor_staff
    when AdminStaff.name
      @user_identify = :admin_staff
    end

    @user.update(user_params)
    redirect_back(fallback_location: admin_admin_users_path, notice: "更新使用者完成")

  end

  def admin
    if current_user.superman?
      @users = User.where.not(type: User.name)
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
    params.require(@user_identify).permit(:role, :name, :email, :password, :vendor_id)
    # 應映三種 user 身份，原本寫了三種user_params、vendor_staff_parmas、admin_staff_parmas
    # 後來改由 @user_identify 判斷身份
  end

end