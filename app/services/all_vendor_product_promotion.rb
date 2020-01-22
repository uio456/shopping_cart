class AllVendorProductPromotion
  class << self

    def perform(the_vandor)

      vendor_products = the_vandor.products
      vendor_products.each do |p|
        p.state = "vendor_p"
        p.save
      end
    end

  end
end