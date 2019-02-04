module Discount
  class << self

    def call(the_product, the_quantity)
      @product = the_product
      @quantity = the_quantity

    # 如果itme數量超過 3 就打折
    # quantity > 3 ? product.price * quantity * 0.8 : product.price * quantity
    # Dicount.new().perform
    # Dicount.perform

      if @product.state.eql?("ItemP") 
         cart_item_discount
      elsif @product.state.eql?("VendorP")
        cart_item_discount
      else
        @product.price * @quantity
      end
    end

    def cart_item_discount
      @quantity >= 3 ? @product.price * @quantity * 0.8 : @product.price * @quantity
    end

  end
end

  # 如果金額超過 1000 @free_product = Product.where(state: "Forfree"].sample
  
  # current_cart 拉近來算，把折扣的金額算出來，在把current_cat 丟回去
  
  # 是否有必要把 current_cart 拉近來變成 DiscountCart
  # 把 current_cart 拉進來後處理後，變成 @discount_cart

  # >>  item.product.state == "1"
  # => true
  # 目前可以判斷 product.state
  # 判斷出來後去改變 @cart 的價錢
  # 要在 cart 這邊就把折扣算出來
  # 直接給 order 還有 order_item 使用
  # 想想判斷出來後怎麼建立