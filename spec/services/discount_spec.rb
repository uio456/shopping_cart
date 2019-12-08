require 'rails_helper'

RSpec.describe do
  let!(:cart) {Cart.new}
  let!(:promotiona) {Promotional.create(title: "promotional", discount_deadline: Time.now+1.years,
                                        vendor_discount: 0.8, item_discount: 0.7)}
  let!(:vendor) {Vendor.create(name: "Eslite")}
  5.times do |i|
    let!("product_#{i}") {Product.create( title: FFaker::Product.product_name,
                                    price: 100,
                                    vendor_id: Vendor.first.id,
                                    state: "normal"
    )}
  end
  describe "計算折扣" do
    context "相同廠商商品滿 3 件打 8 折" do
      before {
        product_0.vendor_p!
        product_1.vendor_p!
        product_2.vendor_p!
      }

      it "2 vendor product" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        order_price = 200
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end

      it "3 vendor product" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_0)
        order_price = (300 * promotiona.vendor_discount)
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end

      it "3 vendor product, 1 normal product" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_1)
        order_price = (300 * promotiona.vendor_discount) + 100
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end

      it "3 vendor product, 2 normal product" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_1)
        cart.add_item(product_1)
        order_price = (300 * promotiona.vendor_discount) + 200
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end
    end

    context "相同商品滿 3 件打 7 折" do
      before {
        product_0.item_p!
        product_1.item_p!
        product_2.item_p!
      }

      it "2 item product" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        order_price = 200
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end

      it "3 item product" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_0)
        order_price = (300 * promotiona.item_discount)
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end

      it "3 item product, 1 normal product" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_1)
        order_price = (300 * promotiona.item_discount) + 100
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end

      it "3 item product, 1 normal product" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_1)
        cart.add_item(product_1)
        order_price = (300 * promotiona.item_discount) + 200
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end
    end

  end
end