class Discount
  def initialize()
    
  end

  def perform
  end

end


# 1. cart_item 滿 X 件折 Y 元或 Z %
# 2. order 滿 X 元折 Y 元或 Z %
# 3. order 滿 X 元免運費 
# 4. order 滿 X 贈送特定商品
# 5. vendor.state == 1 特定供應商場品滿 X 件折 Y 元或 Z %
# 6. order.check 折扣最多 3 次 ，取折扣金額多的前 3 個  ，  折扣可限定只套用 N 次或總共優惠 Y 元
# 7. order_item 如果超過三天未結帳，就凍結/取消， 折扣可限制特定時間內有效或是每月重新計算使用數量限制