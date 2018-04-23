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
      flash[:success] = "New category added"
      redirect_to :back
    else
      flash.now[:alert] = @category.errors
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
