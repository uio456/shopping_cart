module Discount
  class << self

    MAXIMUM_DISCOUNT = 500

    def call
    end

    def cart_item_discount(the_product, the_quantity)
      @product = the_product
      @quantity = the_quantity
      
      if @product.state.eql?("ItemP") 
         cart_item_total
      elsif @product.state.eql?("VendorP")
        cart_item_total
      else
        @product.price * @quantity
      end
    end

    def cart_item_total
      @quantity >= 3 ? watching_cart_item_discount : @product.price * @quantity
    end

    def watching_cart_item_discount
      @watching_cart_item_discount = (@product.price * @quantity) - (@product.price * @quantity * 0.8) 
      # 算出打折金額
      if @watching_cart_item_discount > MAXIMUM_DISCOUNT
         @watching_cart_item_discount = MAXIMUM_DISCOUNT
         # 最多折 500 
      end
      @product.price * @quantity - @watching_cart_item_discount
      # 回傳這條 cart_item 金額
    end

    def cart_final_price(cart_item_price, shipping_fee)
      # 這裡 cart_item_price 已是所有 cart_item 金額
      if cart_item_price >= 1000 
        @watching_cart_discount = (cart_item_price) - (cart_item_price * 0.8) 
        unless @watching_cart_item_discount + @watching_cart_discount <= 500
          cart_item_price - (MAXIMUM_DISCOUNT - @watching_cart_item_discount) + shipping_fee
        end
        cart_item_price - @watching_cart_discount + shipping_fee
      end
      cart_item_price + shipping_fee
      # 還未限定折扣金額時的算法 final_price = cart_item_price >= 1000 ? cart_item_price * 0.8 + shipping_fee : cart_item_price + shipping_fee
    end

    def free_product(current_cart)
      free_product = Product.where(state: "ForFree").sample
      # 如果 product 都沒有 Free 的就不繼續
      if free_product.present? &&  check_free_product(current_cart)
        free_product.price = 0
        free_product.save
        current_cart.add_item(free_product.id)
        # 金額大於 800 送特定商品
        # 把 products.state == "ForFree" 的商品變成 0 元
      end
    end

    #  如果 currem_cart 裡面已經有 Free Product 就給 false
    def check_free_product(current_cart)
      current_cart.items.map do |i|
        return false if i.product.state == "ForFree"
      end
    end
    

  end
end

# def price_with_discount
#   return self.price if self.discount.nil? || self.discount.zero?
#   self.price - (self.price / self.discount)
# end

# <%= product.price_with_discount %>
  
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