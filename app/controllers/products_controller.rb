class ProductsController < ApplicationController
  def index
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
  end

  def destroy
  end

  private

  def product_params
    return params.require(:product).permit(:name, :description, :price, category_ids: [])
  end
end
