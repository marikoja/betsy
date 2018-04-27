# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

USER_FILE = Rails.root.join('db', 'MerchantSeed.csv')
puts "Loading user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.name = row['name']
  user.email = row['email']
  user.uid = row['UID']
  user.provider = row['provider']

  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

PRODUCT_FILE = Rails.root.join('db', 'ProductSeed2.csv')
puts "Loading product data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.name = row['Product']
  product.price = row['price']
  product.description = row['description']
  product.image = row['image']
  product.user_id = row['user_id']
  product.quantity = rand(1..50)

  # add category to product
  if row['category'] != "-"
    category = Category.find_by(name: row['category'])
    if category
      product.categories << category
    else
      category = Category.new
      category.name = row['category']
      category.save
      puts "Category created: #{category.inspect}"
      product.categories << category
    end
  end

  successful = product.save
  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}"
  else
    puts "Created product: #{product.inspect}"
  end
end

# CATEGORY_FILE = Rails.root.join('db', 'Categoryseed.csv')
# puts "Loading category data from #{CATEGORY_FILE}"
#
# category_failures = []
# CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
#   category = Category.new
#   category.name = row['Category']
#
#   successful = category.save
#   if !successful
#     category_failures << category
#     puts "Failed to save category: #{category.inspect}"
#   else
#     puts "Created category: #{category.inspect}"
#   end
# end

REVIEW_FILE = Rails.root.join('db', 'ReviewsSeed.csv')
puts "Loading review data from #{REVIEW_FILE}"

review_failures = []
CSV.foreach(REVIEW_FILE, :headers => true) do |row|
  review = Review.new
  review.product_id = row['product_id']
  review.rating = row['rating']
  review.text_review = row['text_review']

  successful = review.save
  puts successful
  if !successful
    review_failures << review
    puts "Failed to save review: #{review.inspect}"
  else
    puts "Created review: #{review.inspect}"
  end
end

ORDER_FILE = Rails.root.join('db', 'OrdersSeed.csv')
puts "Loading order data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new
  order.user_id = row['user_id']
  order.name = row['name']
  order.card_number = row['card_number']
  order.email = row['email']
  order.street = row['street']
  order.city = row['city']
  order.state = row['state']
  order.zip = row['zip']
  order.date_year = row['date_year']
  order.date_month = row['date_month']
  order.date_day = row['date_day']
  order.cvv = row['cvv']
  order.status = row['status']

  successful = order.save
  if !successful
    order_failures << order
    puts "Failed to save order: #{order.inspect}"
  else
    puts "Created order: #{order.inspect}"
  end
end

ORDER_ITEM_FILE = Rails.root.join('db', 'OrderItemsSeed.csv')
puts "Loading order_item data from #{ORDER_ITEM_FILE}"

order_item_failures = []
CSV.foreach(ORDER_ITEM_FILE, :headers => true) do |row|
  order_item = OrderItem.new
  order_item.order_id = row['order_id']
  order_item.product_id = row['product_id']
  order_item.quantity = row['quantity']
  order_item.status = row['status']

  successful = order_item.save
  if !successful
    order_item_failures << order_item
    puts "Failed to save order_item: #{order_item.inspect}"
  else
    puts "Created order_item: #{order_item.inspect}"
  end
end
