class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 驗證格式
  # validates :email, presence: true, format: { with: /\A[\w+\-.\[\]]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}, uniqueness: true

  scope :all_customers, -> {where(role: "normal")}

  has_many :orders
  has_many :favorites, dependent: :destroy
  has_many :favorited_products, through: :favorites, source: :product

  ROLE = ["normal", "admin", "superman"]
  # 把顧客的role 變成空字串
  # superman 超人
  # admin 我管理員、廠商超人
  # normal 普通廠商員工
  # I18n 轉換

  def admin?
    role != "normal"
  end

  def superman?
    role == "superman"
  end

  def vendor_admin?
    vendor_id.present? && admin?
  end

end
