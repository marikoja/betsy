class User < ApplicationRecord
  has_many :orders
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true


  def self.build_from_github(auth_hash)
    return User.new(uid: auth_hash[:uid], provider: auth_hash[:provider], email: auth_hash[:info][:email], name: auth_hash[:info][:nickname])
  end

end
