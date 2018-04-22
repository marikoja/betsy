require "test_helper"

describe CategoriesController do
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

  
  #   it "should get index" do
  #     get categories_index_url
  #     value(response).must_be :success?
  #   end
  #
  #   it "should get show" do
  #     get categories_show_url
  #     value(response).must_be :success?
  #   end
  #
  #   it "should get new" do
  #     get categories_new_url
  #     value(response).must_be :success?
  #   end
  #
  #   it "should get create" do
  #     get categories_create_url
  #     value(response).must_be :success?
  #   end
  #
  #   it "should get edit" do
  #     get categories_edit_url
  #     value(response).must_be :success?
  #   end
  #
  #   it "should get update" do
  #     get categories_update_url
  #     value(response).must_be :success?
  #   end
  #
  #   it "should get show" do
  #     get categories_show_url
  #     value(response).must_be :success?
  #   end
  #
  #   it "should get destroy" do
  #     get categories_destroy_url
  #     value(response).must_be :success?
  #   end
  #
  end
