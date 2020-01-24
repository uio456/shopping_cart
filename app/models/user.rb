class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_customers, -> {where(role: "normal")}
  scope :all_admin, -> {where.not(role: "normal")}

  has_many :orders

  has_many :favorites, dependent: :destroy
  has_many :favorited_products, through: :favorites, source: :product

  ROLE = ["normal", "admin", "superman"]

  def admin?
    role != "normal"
  end

  def superman?
    role == "superman"
  end

end
