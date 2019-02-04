class CartItem
  attr_reader :product_id, :quantity

  def initialize(product_id, quantity = 1)
    @product_id = product_id
    @quantity = quantity
  end

  def increment(n = 1)
    @quantity += n
  end

  def product
    # 讓 item 可以找到 Product 
    # 這裡沒直接設定資料表間的關聯(has_many、belong_to)
    # 用方法或語法去找關聯，CartItem 是屬於 Cart， Product 是屬用 CartIem
    Product.find_by(id: product_id)
  end

  def price
    Discount.call(product, quantity)
  end

end