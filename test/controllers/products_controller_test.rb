require "test_helper"

describe ProductsController do

  describe "index" do

    it "succeeds with multiple products" do
      get products_path
      must_respond_with :success
    end

    it "succeeds with no categories " do
      products = Product.all
      products.each do |prod|
        prod.destroy
      end
      get products_path
      must_respond_with :success

    end

  end

  
  # it "should get index" do
  #   get products_index_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get new" do
  #   get products_new_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get create" do
  #   get products_create_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get edit" do
  #   get products_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get update" do
  #   get products_update_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get show" do
  #   get products_show_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get destroy" do
  #   get products_destroy_url
  #   value(response).must_be :success?
  # end

end
