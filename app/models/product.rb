class Product < ApplicationRecord
  belongs_to :vendor
  has_many :taggings
  has_many :tags, through: :taggings

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user


  validates_presence_of :vendor, :title, :price, :state
  validate :check_product_price

  default_scope { order(updated_at: :desc) }
  scope :avalible_products, -> { where(state: ["vendor_p", "normal", "item_p"])}
  enum state: {vendor_p: "vendor_p", normal: "normal", item_p: "item_p", for_free: "for_free"}


  def check_product_price
    if price <= 0
      errors.add(:price, "can't not less then 0")
    end
  end

  def tag_list
    tags.map(&:name).join(',')
    # 相等於 tags.map { |tag| tag.name }.join(' ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end

  def is_favorited?(user)
    self.favorites.where(user_id: user, cancel_at: nil).present?
  end

end
