require 'rails_helper'

RSpec.describe do
  let!(:cart) {Cart.new}
  let!(:promotiona) {Promotional.create(title: "promotional", discount_deadline: Time.now+1.years,
                                        vendor_discount: 0.8, item_discount: 0.8)}
  let!(:vendor) {Vendor.create(name: "Eslite")}
  5.times do |i|
    let!("product_#{i}") {Product.create( title: FFaker::Product.product_name,
                                    price: 100,
                                    vendor_id: Vendor.all.sample.id,
                                    state: "normal"
    )}
  end
  describe "計算折扣" do
    context "相同廠商商品打 8 折" do
      before {
        product_0.vendor_p!
        product_1.vendor_p!
        product_2.vendor_p!
      }
      it "3件相同廠商的商品，打 8 折" do
        cart.add_item(product_0)
        cart.add_item(product_0)
        cart.add_item(product_0)
        order_price = (product_0.price * cart.count_items * promotiona.vendor_discount)
        expect(cart.total_price.to_i).to be((order_price + cart.shipping_fee).to_i )
      end
    end
  end
end