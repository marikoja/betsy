class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
    if @category.nil?
      flash[:status] = :alert
      flash[:result_text] = "That category does not exist"
      redirect_to root_path
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:status] = :success
      flash[:result_text] = "New category added"
      redirect_to new_product_path
    else
      flash[:status] = :alert
      flash.now[:messages] = @category.errors.messages
      render :new, status: :bad_request
    end
  end

  def category_params
    return params.require(:category).permit(:name, product_ids: [])
  end
end
