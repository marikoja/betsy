require "test_helper"

describe UsersController do

  # describe "index" do
  #   it "succeeds when there are users" do
  #
  #     get users_path
  #     must_respond_with :success
  #   end
  #
  #   it "succeeds when there are no users" do
  #
  #     users = User.all
  #     users.each do |user|
  #       user.products.destroy
  #       user.destroy
  #     end
  #     get users_path
  #     must_respond_with :success
  #   end
  #
  # end
  #
  # describe "create" do
  #   it "succeeds with an existing username and redirects to root_path" do
  #
  #
  #     must_redirect_to root_path
  #
  #   end
  #
  #   it "succeeds with new valid username and redirects to root path" do
  #     new_user = User.new(
  #       provider: 'githib',
  #       uid: 999,
  #       username: 'test user',
  #       email: 'test@test.com'
  #     )
  #
  #     proc {
  #       perform_login(new_user)
  #     }.must_change 'User.count', 1
  #
  #
  #     must_respond_with :redirect
  #     must_redirect_to root_path
  #   end
  #
  #   it "renders bad_request with invalid username" do
  #     skip
  #     new_user = User.new(
  #       provider: 'githib',
  #       uid: 999,
  #       username:'',
  #       email: 'test@test.com'
  #     )
  #
  #     proc {
  #       perform_login(new_user)
  #     }.must_change 'User.count', 0
  #
  #
  #     must_respond_with :bad_request
  #   end
  # end
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

  ###### The above controller tests are great. I just added the OAuth tests below: #######

  describe "auth_callback" do

    # test/controllers/users_controller_test.rb
    it "logs in an existing user" do
      start_count = User.count
      user = users(:beyonce)

      login(user)
      must_redirect_to root_path
      session[:user_id].must_equal  user.id

      User.count.must_equal start_count
    end

    it "creates an account for a new user and redirects to the root route" do

      start_count = User.count
      user = User.new

      user.name = "not bey"
      user.email = "not_beyonce@github.com"
      user.uid = 1101
      user.provider = "github"

      user.save

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      get auth_callback_path(:github)

      must_redirect_to root_path

      # I made other user below, that should not have saved.
      # How come it saved below and returns as the last User.id?
      # session[:user_id].must_equal User.last.id
      # I changed it to a find_by method and confirmed that the username is the same.
      session_user = User.find(session[:user_id])

      user.name.must_equal session_user.name

      User.count.must_equal (start_count + 1)
    end

    it "redirects to the login route if given invalid user data" do
      invalid_user = User.new
      invalid_user.name = nil
      invalid_user.save

      get auth_callback_path(:github)

      # what is the proper login path then???
      # why doesn't it have to redirect to github_login?
      must_redirect_to root_path

      # why don't we also check that session user_id ?
      # b/c it will be a nill value
      # Why don't we check/how do we check that session user_id is a nil value?
    end
  end

end
