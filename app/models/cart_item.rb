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
    # 如果itme數量超過 3 就打折
    # quantity > 3 ? product.price * quantity * 0.8 : product.price * quantity
    if product.state.eql?("ItemP") 
      cart_item_discount
    elsif product.state.eql?("VendorP")
      cart_item_discount
    else
      product.price * quantity
    end
    # product.price * quantity
  end

  def cart_item_discount
    quantity >= 3 ? product.price * quantity * 0.8 : product.price * quantity
  end

end