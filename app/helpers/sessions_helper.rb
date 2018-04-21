module SessionsHelper
  def calculate_total
    total = 0
    session[:order].each do |key, val|
      product = Product.find_by(id: key.to_i)
      subtotal = product.price * val
      total += subtotal
    end
    return total
  end
end
