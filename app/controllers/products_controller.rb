class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new

  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def destroy
  end

  private

  def product_params
    return params.require(:product).permit(:name, :description, :image, :price)
  end
end
