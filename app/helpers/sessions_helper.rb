module SessionsHelper
  def calculate_total
    total = 0
    if session[:order].nil?
      return total
    else
      session[:order].each do |key, val|
        product = Product.find_by(id: key.to_i)
        subtotal = product.price * val
        total += subtotal
      end
      return sprintf('%.2f', total.to_f)
    end
  end
end
