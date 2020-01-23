class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_customers, -> {where(role: "normal")}

  has_many :orders

  ROLE = ["normal", "admin", "superman"]

  def admin?
    role != "normal"
  end

end
