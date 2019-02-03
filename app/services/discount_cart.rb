class DiscountCart

  # current_cart 拉近來算，把折扣的金額算出來，在把current_cat 丟回去

  # 是否有必要把 current_cart 拉近來變成 DiscountCart
  # 把 current_cart 拉進來後處理後，變成 @discount_cart

  def initialize(cart)
    @cart = cart
  end

  def perform
    @cart
  end

  # def add_order_items(current_cart)
  #   current_cart.items.each do |item|
  #     self.order_items.build(
  #       product_id: item.product.id,
  #       quantity: item.quantity, 
  #       price: item.product.price 
  #     )
  #   end
  # end

  def discount_item
    @filter_cart = @cart.items.each do |item|
                       item.price * 0.8 if item.quantity >= 3 
                     end


  # >>  item.product.state == "1"
  # => true
  # 目前可以判斷 product.state
  # 判斷出來後去改變 @cart 的價錢
  # 要在 cart 這邊就把折扣算出來
  # 直接給 order 還有 order_item 使用
  # 想想判斷出來後怎麼建立  
  end

  def discount_order
    
  end

  def discount_vendor
    
  end

  def total_discount
    
  end

  def discount_deadline
    
  end

end


# 1. cart_item 滿 X 件折 Y 元或 Z %
# 2. order 滿 X 元折 Y 元或 Z %
# 3. order 滿 X 元免運費 
# 4. order 滿 X 贈送特定商品
# 5. vendor.state == 1 特定供應商場品滿 X 件折 Y 元或 Z %
# 6. order.check 折扣最多 3 次 ，取折扣金額多的前 3 個  ，  折扣可限定只套用 N 次或總共優惠 Y 元
# 7. order_item 如果超過三天未結帳，就凍結/取消， 折扣可限制特定時間內有效或是每月重新計算使用數量限制