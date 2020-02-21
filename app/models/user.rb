class User < ApplicationRecord
  before_create :generate_authentication_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # email 驗證格式
  # validates :email, presence: true, format: { with: /\A[\w+\-.\[\]]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}, uniqueness: true

  scope :all_customers, -> {where(role: "normal")}

  has_many :orders
  has_many :favorites, dependent: :destroy
  has_many :favorited_products, through: :favorites, source: :product

  ROLE = ["normal", "admin", "superman"]

  # FIXME，修改成 enum 存取 role，增加安全性。
  # enum role: {
  #   # 存取語法 User.roles
  #   customer: "customer",
  #   normal: "normal",
  #   admin: "admin",
  #   superman: "superman"
  # }

  def superman?
    role == "superman"
  end

  def admin?
    role != "normal"
  end

  def vendor_admin?
    vendor_id.present? && admin?
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

end
