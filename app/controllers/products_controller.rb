class ProductsController < ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_url, notice: 'New Product Created'
    else
      render new_product_path
    end
  end

  def new
    @product = Product.new
  end

  def index
    @products = Product.all.order_by(:sort_order.asc)
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_url, notice: "Product #{@product.name} was successfully updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: "Product #{@product.name} deleted"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :unit, :sort_order)
  end
end
