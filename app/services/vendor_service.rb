module VendorService
  class << self
    def call(the_vandor)
      vendor_products = the_vandor.products
      vendor_products.each do |p|
        p.state = "VendorP"
        p.save
      end
    end
  end
end