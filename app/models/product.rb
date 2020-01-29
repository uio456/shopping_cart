class Product < ApplicationRecord
  belongs_to :vendor
  has_many :taggings
  has_many :tags, through: :taggings

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user


  validates_presence_of :vendor, :title, :price, :state
  validates_numericality_of :price, only_integer: true, greater_than_or_equal_to: 0

  default_scope { order(updated_at: :desc) }
  scope :avalible_products, -> { where(state: ["vendor_p", "normal", "item_p"])}
  enum state: {vendor_p: "vendor_p", normal: "normal", item_p: "item_p", for_free: "for_free"}


  def tag_list
    tags.map(&:name).join(',')
    # 相等於 tags.map { |tag| tag.name }.join(',')
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
