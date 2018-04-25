class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:status] = :success
      flash[:result_text] = "New category added"
      # render 'product/new'
      redirect_to new_product_path
    else
      flash[:status] = :alert
      flash.now[:messages] = @category.errors.messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def category_params
    return params.require(:category).permit(:name)
  end
end
