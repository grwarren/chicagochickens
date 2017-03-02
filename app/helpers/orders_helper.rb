module OrdersHelper
  IGNORE_PLURALIZE = ["Dozen"]

  def pluralize_units(num, product_name)
    product = Product.find_by(name: product_name)
    ((num == 0 or num > 1) and !IGNORE_PLURALIZE.include?(product.unit)) ? "#{num} #{product.unit.pluralize}" : "#{num} #{product.unit}"
  end

  def quantity_options_for(product_name)
    (0..10).to_a.collect { |n| [" #{pluralize_units(n, product_name) }", n] }
  end

  def order_headers(order)
    order.nil? ? "Order" : "Order for #{order.user_name} on #{order.delivery_date.strftime('%b %-d')}"
  end
end
