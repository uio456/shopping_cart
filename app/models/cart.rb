class Cart
  SessionKey = :cart9488
  
  attr_reader :items
  # Ruby 的實體變數 (這裡為例的話，Cart 是一個實體，Cart 目前有一個變數是 items )，外部無法直接使用，需設定 getter 或 writter，才能
  # 這裡設定 attr_reader 就是 getter，幫忙拿到 items 的值

  def initialize(item = [])
    @items = item
  end

  def add_item(product_id)
    found_item = items.find { |item| item.product_id == product_id }
    if found_item
      found_item.increment
    else
      @items << CartItem.new(product_id)
    end
  end

  def count_items
    @total_items = []
    items.map do |item|
      @total_items << item.quantity
    end
    @total_items.reduce { |sum, x| sum + x }
  end

  # def empty?
  #   items.empty?
  # end

# 先算出整台車 cart_item 的金額
  def cart_item_price
    cart_item_price = items.reduce(0) { |sum, cart_item| sum + cart_item.price }
    # 總數由 0 開始計算，把每一個 cart_item 金額都算出來，在相加起來。
  end

  def cart_item_discount_price
    @cart_item_discount_price = items.reduce(0) { |sum, cart_item| sum + cart_item.discount_price }
  end

# 運費預設 150 
  def shipping_fee
    shipping_fee = cart_item_price >= 500 ? 0 : 150
    # 運費改成可以從後台輸入
  end

# 總費用超過 1000 打 8 折，超過 500 免運費
  def total_price
    Discount.cart_final_price(cart_item_price, shipping_fee, cart_item_discount_price)
  end

# 因要使用 session，所以需讓回傳格式為 Hash
  def serialize
    all_items = items.map { |item|
      { "product_id" => item.product_id, "quantity" => item.quantity}
    }

    { "items" => all_items }
  end

  class << self
    # 因為 cart 增加商品後，是透過 session 存起來，所以都需轉乘 hash 形式。
    # 所以每次在增加商品前，需把 cart 裡面的值，先轉回 Array 形式。
    # 每次呼叫 cart 都會先進來，所以如果 cart 是空的就直接給一個空的 Array
    def from_hash(hash)
      if hash.nil?
        new []
      else
        new hash["items"].map { |item_hash|
          CartItem.new(item_hash["product_id"], item_hash["quantity"])
        }
      end
    end
  end

end