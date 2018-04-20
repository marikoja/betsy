require "test_helper"

describe User do
  let(:user) { User.new name: "Bey", email: "bey@yonce.com", uid: 2231, provider: "yonce"}

  it "must be valid" do
    user.save
    value(user).must_be :valid?
  end

  it "is invalid when missing a name" do
    user.name = nil
    user.save
    user.valid?.must_equal false
  end

  it "is invalid when given a non-unique name" do
    user.name = "Bey"
    user.save
    dup_user_name = User.new
    dup_user_name.name = "Bey"
    dup_user_name.save
    dup_user_name.valid?.must_equal false
  end
end
