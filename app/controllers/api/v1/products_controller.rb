class Api::V1::ProductsController < ApiController
  before_action :authenticate_user!


  def index
    @products = Product.all
    render json: {
      token: {token: current_user.authentication_token},
      data: @products.map do |product|
        {
          products: {
          id: product.id,
          title: product.title,
          description: product.description
          }
         }
      end
    }
  end

  def show
    @product = Product.find_by(id: params[:id])
    if !@product
      render json: {
        error_message: "Can't find the product!",
        status: 400
      }
    else
      render json: {
        # data: @product  #可直接回傳全部屬性
        id: @product.id,
        title: @product.title,
        description: @product.description
      }
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: {
        message: "product created successfully!",
        result: @product
      }
    else
      render json: {
        errors: @product.errors
      }
    end
  end

  private

  def product_params
    params.permit(:title, :description, :price, :vendor_id, :state, :tag_list)
  end


end
