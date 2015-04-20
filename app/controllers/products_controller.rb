class ProductsController < ApplicationController

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to new_product_path, notice: 'New Product Created'
    else
      render new_product_path
    end
  end

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  private
  def product_params
    params.require(:product).permit(:name, :unit)
  end
end
