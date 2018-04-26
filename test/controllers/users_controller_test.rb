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

  describe "show" do
    it "succeeds with a valid id" do
      user = users(:ron)
      get users_path(user.id)
      must_respond_with :success
    end
  end

  describe "edit" do
    it "succeeds with valid data" do
      user = users(:ron)
      login(user)
      get edit_user_path(user.id)
      must_respond_with :success
    end
  end

  describe "update" do
    it "successfully updates user information" do
      user = users(:ron)
      login(user)
      proc {
        patch user_path(user.id), params: {
          user: {
            name: 'ronnie',
            email: 'new_email@gmail.com'
          }
        }
      }.must_change 'User.count', 0
      must_redirect_to user_path(user.id)
    end
  end

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

      session_user = User.find(session[:user_id])

      user.name.must_equal session_user.name

      User.count.must_equal (start_count + 1)
    end

    it "redirects to the login route if given invalid user data" do
      invalid_user = User.new
      invalid_user.name = nil
      invalid_user.save

      get auth_callback_path(:github)

      must_redirect_to root_path
    end
  end

end
