module OrdersHelper
  IgnorePluralize = ["Dozen"]

  def pluralize_units(num, product)
    product.unit.empty? ? "#{num} #{product.name}" : (num > 1 and !IgnorePluralize.include?(product.unit)) ? "#{num} #{product.unit.pluralize}" : "#{num} #{product.unit}"
  end

  def quantity_options_for(product)
    (0..10).to_a.collect { | n | [" #{pluralize_units(n, product) }", n ] }
  end
end
