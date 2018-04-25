require "test_helper"

describe ProductsController do

  describe "index" do

    it "succeeds with multiple products" do
      get products_path
      must_respond_with :success
    end

    it "succeeds with no products " do
      products = Product.all
      products.each do |prod|
        prod.destroy
      end
      get products_path
      must_respond_with :success

    end

  end

  describe 'root' do

    it "succeeds" do
      get root_path
      must_respond_with :success
    end

    it "succeeds with no products" do
      products = Product.all
      products.each do |prod|
        prod.reviews.destroy
        prod.destroy
      end
      get root_path
      must_respond_with :success
    end
  end

  describe 'new' do
    it "succeeds with a logged in user" do
      user = users(:beyonce)
      login(user)

      get new_product_path
      must_respond_with :success
    end

    it "redirects without a user" do
      get new_product_path
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe 'create' do
    it "creates a work with valid data for a real category" do
      user = users(:beyonce)
      login(user)

      proc {
          post products_path, params: {
            product: {
              name: 'pear',
              price: 4.0,
              description: 'peary',
              image: 'image',
              user: user,
              quantity: 5
            }
          }
        }.must_change 'Product.count', 1

        must_respond_with :redirect
        must_redirect_to user_products_url(user.id)
    end

    it "Does not update the DB for bogus data" do
      existing_user = users(:beyonce)

      login(existing_user)

      proc {
          post products_path, params: {
            product: {
              name: nil,
              price: 4.0,
              description: 'peary',
              image: 'image',
              user: existing_user,
              quantity: nil
            }
          }
        }.must_change 'Product.count', 0

    end
  end

  describe "edit" do
    it "succeeds for a logged in user with their own product" do
      user = users(:beyonce)
      product = products(:cherries)

      login(user)

      get edit_product_path(product.id)
      must_respond_with :success

    end

    it "redirects someone without permissions to edit a product" do

      product = products(:cherries)
      get edit_product_path(product.id)

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "redirects to the root path if the product does not exist" do
      user = users(:beyonce)

      login(user)

      get edit_product_path(800)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "update" do
    it "succeeds for valid data and a logged on user with permissions" do
      user = users(:beyonce)
      product = products(:cherries)

      login(user)

      patch product_path(product.id), params: {
        product: {
          name: 'yellow cherries',
          price: 3.0,
          description: '1kg ranier cherries',
          image: 'image_url',
          user: user,
          quantity: 4
        }
      }

      product.name.must_equal 'yellow cherries'
      must_respond_with :redirect
      must_redirect_to product_path(product.id)
    end
    #
    # it "renders bad_request for bogus data" do
    #
    #
    # end

    it "redirects to the product index if product does not exist" do
      user = users(:beyonce)
      product = products(:cherries)

      login(user)

      patch product_path(789)
      must_respond_with :redirect
      must_redirect_to products_path

    end
  end

  describe "show" do
    it "succeeds for an exisiting work" do
      product = products(:cherries)

      get product_path(product.id)
      must_respond_with :success
    end

    it "redirects to products path if a product does not exist" do
      get product_path(984)
      must_respond_with :redirect
      must_redirect_to products_path
    end
  end

  describe "destroy" do
    it "succeeds for an existing product for user with permissions" do
      user = users(:beyonce)
      product = products(:cherries)
      login(user)

      delete product_path(product.id)
      must_respond_with :redirect
      must_redirect_to user_products_path(user.id)
    end

    it "must delete product from database if successful" do
      user = users(:beyonce)
      product = products(:cherries)
      login(user)

      count = Product.count
      delete product_path(product.id)

      Product.count.must_equal count - 1
    end

    it "redirects for a nonexistant product id" do
      user = users(:beyonce)
      product = products(:cherries)
      login(user)

      delete product_path(789)
      must_respond_with :redirect
      must_redirect_to products_path
    end
  end

end
