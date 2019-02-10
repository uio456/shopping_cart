module Discount
  class << self

    MAXIMUM_DISCOUNT = 500
    DISCOUNT_DEADLINE = Time.new(2019,3,1)
    # 暫定優惠只到 2019/2/28 23:59:59

    def call
    end

    def cart_item_total(the_product, the_quantity)
      @product = the_product
      @quantity = the_quantity
      
      if @product.state.eql?("ItemP") && check_discount_deadline
         @quantity >= 3 ? watching_cart_item_discount : @product.price * @quantity
      elsif @product.state.eql?("VendorP") && check_discount_deadline
        @quantity >= 3 ? watching_cart_item_discount : @product.price * @quantity
      else
        @product.price * @quantity
      end
    end

    def watching_cart_item_discount
      @watching_cart_item_discount = (@product.price * @quantity) - (@product.price * @quantity * 0.8) 
      @watching_cart_item_discount = 0 if @watching_cart_item_discount == nil
      # 算出打折金額
      @product.price * @quantity - @watching_cart_item_discount
      # 回傳這條 cart_item 金額
    end

    def cart_item_discount_price(the_product, the_quantity)
       @discount_product = the_product
       @discount_quantity = the_quantity
      if @discount_product.state.eql?("ItemP") && check_discount_deadline
        return price = (@discount_product.price * @discount_quantity * 0.2) if @discount_quantity >= 3
        # 如有 3 件才打折，如 3件以下不打折，最底下回傳 price = 0
      elsif @discount_product.state.eql?("VendorP") && check_discount_deadline
        return price = (@discount_product.price * @discount_quantity * 0.2) if @discount_quantity >= 3
      else
        return price = 0
      end
        price = 0
    end

    def cart_final_price(cart_item_price, shipping_fee, cart_item_discount_price)
      # 這裡 cart_item_price 已是所有 cart_item 金額

      if cart_item_price >= 1000 && check_discount_deadline
        @watching_cart_discount = (cart_item_price) - (cart_item_price * 0.8) 
        if  @watching_cart_discount + cart_item_discount_price <= MAXIMUM_DISCOUNT
          cart_item_price - @watching_cart_discount + shipping_fee
        else
          # 沒限制 cart_item_discount_price ， 但如果折超過 500 ，這裡會加回去
          cart_item_price - (MAXIMUM_DISCOUNT - cart_item_discount_price) + shipping_fee
        end
      else
        cart_item_price + shipping_fee
      end
      # 還未限定折扣金額時的算法 final_price = cart_item_price >= 1000 ? cart_item_price * 0.8 + shipping_fee : cart_item_price + shipping_fee
    end

    def free_product(current_cart)
      free_product = Product.where(state: "ForFree").sample
      # 如果 product 不是 Free的 就不繼續，否則會出錯
      if free_product.present? &&  check_free_product(current_cart)
        free_product.price = 0
        free_product.save
        current_cart.add_item(free_product.id)
        # 金額大於 800 送特定商品
      end
    end

    #  如果 currem_cart 裡面已經有 Free Product 就不再送
    def check_free_product(current_cart)
      current_cart.items.map do |cart_item|
        return false if cart_item.product.state == "ForFree"
      end
    end

    def check_discount_deadline
      DISCOUNT_DEADLINE > Time.now
    end

  end
end

# def price_with_discount
#   return self.price if self.discount.nil? || self.discount.zero?
#   self.price - (self.price / self.discount)
# end
