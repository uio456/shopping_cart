class ProductsController < ApplicationController

  def index
    @products = Product.avalible_products.includes(:vendor)
  end
end