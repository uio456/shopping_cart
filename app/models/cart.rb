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

  def empty?
    items.empty?
  end

  def total_price
    items.reduce(0) { |sum, item| sum + item.price }
  end

# 因要使用 session，所以需讓回傳格式為 Hash
  def serialize
    all_items = items.map { |item|
      { "product_id" => item.product_id, "quantity" => item.quantity}
    }

    { "items" => all_items }
  end

  class << self
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