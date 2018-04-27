class User < ApplicationRecord
  has_many :orders
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true


  def self.build_from_github(auth_hash)
    return User.new(uid: auth_hash[:uid], provider: auth_hash[:provider], email: auth_hash[:info][:email], name: auth_hash[:info][:nickname])
  end

MERCHANT_PICS = ['https://www.icreativeideas.com/wp-content/uploads/2014/08/Creative-Animals-Made-of-Fruits-And-Vegetables-4.jpg', 'https://www.icreativeideas.com/wp-content/uploads/2014/08/Creative-Animals-Made-of-Fruits-And-Vegetables-26.jpg', 'https://www.icreativeideas.com/wp-content/uploads/2014/08/Creative-Animals-Made-of-Fruits-And-Vegetables-27.jpg', 'https://www.icreativeideas.com/wp-content/uploads/2014/08/Creative-Animals-Made-of-Fruits-And-Vegetables-28.jpg', 'https://www.icreativeideas.com/wp-content/uploads/2014/08/Creative-Animals-Made-of-Fruits-And-Vegetables-29.jpg', 'https://www.icreativeideas.com/wp-content/uploads/2014/08/Creative-Animals-Made-of-Fruits-And-Vegetables-30.jpg' ]

end
