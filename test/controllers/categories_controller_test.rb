require "test_helper"

describe CategoriesController do
  let(:cherries) { products(:cherries) }

  describe "index" do
    it "succeeds with multiple categories" do
      get categories_path
      must_respond_with :success
    end

    it "succeeds with no categories " do
      categories = Category.all
      categories.each do |cat|
        cat.destroy
      end
      get categories_path
      must_respond_with :success
    end

    it "succeeds with some categories " do
      categories = Category.where(name: 'summer fruit')
      categories.each do |cat|
        cat.destroy
      end
      get categories_path
      must_respond_with :success
    end
  end

  # describe "show" do
  #   it "succeeds for an existing product id" do
  #     # product = cherries
  #     binding.pry
  #     get category_path(cherries)
  #     must_respond_with :success
  #   end
  # end

end
