require "test_helper"

describe UsersController do

  describe "index" do
    it "succeeds when there are users" do

      get users_path
      must_respond_with :success
    end

    it "succeeds when there are no users" do

      users = User.all
      users.each do |user|
        user.products.destroy
        user.destroy
      end
      get users_path
      must_respond_with :success
    end

  end

  describe "create" do
    it "succeeds with an existing username and redirects to root_path" do
    

      must_redirect_to root_path

    end

    it "succeeds with new valid username and redirects to root path" do
      new_user = User.new(
        provider: 'githib',
        uid: 999,
        username: 'test user',
        email: 'test@test.com'
      )

      proc {
        perform_login(new_user)
      }.must_change 'User.count', 1


      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "renders bad_request with invalid username" do
      skip
      new_user = User.new(
        provider: 'githib',
        uid: 999,
        username:'',
        email: 'test@test.com'
      )

      proc {
        perform_login(new_user)
      }.must_change 'User.count', 0


      must_respond_with :bad_request
    end
  end
  # it "should get index" do
  #   get users_index_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get show" do
  #   get users_show_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get new" do
  #   get users_new_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get create" do
  #   get users_create_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get edit" do
  #   get users_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get update" do
  #   get users_update_url
  #   value(response).must_be :success?
  # end

end
