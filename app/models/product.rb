class Product < ApplicationRecord
  has_and_belongs_to_many :categories, join_table: :categories_products
  belongs_to :user
  has_many :reviews

  accepts_nested_attributes_for :categories

  validates :name, {
    presence: true,
    length: { minimum: 1 }
  }

  validates :price, {
    presence: true,
    numericality: { greater_than: 0 }
  }

  def categories_attributes=(category_attributes)
    if !category_attributes.nil?
      category_attributes.values.each do |category_attribute|
        category = Category.find_or_create_by(category_attribute)
        self.categories << category
      end
    end
  end

end
