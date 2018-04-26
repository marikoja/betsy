require "test_helper"

describe CategoriesController do
  let(:cherries) { products(:cherries) }
  let(:valid_category) { categories(:summer) }

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

  describe "show" do
    it "succeeds for a valid category" do
      get category_path(valid_category.id)
      must_respond_with :success
    end

    it "redirects to root path for invalid id" do
      get category_path(999)
      must_redirect_to root_path
    end
  end

  describe "new" do
    it "succeeds" do
      get new_category_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "succeeds with valid data" do
      proc {
        post categories_path, params: {
          category: {
            name: "new category"
          }
        }
      }.must_change 'Category.count', 1

      must_respond_with :found
      must_redirect_to new_product_path
    end

    it "fails with invalid data" do
      proc {
        post categories_path, params: {
          category: {
            name: nil
          }
        }
      }.must_change 'Category.count', 0
      must_respond_with :bad_request
    end
  end

end
