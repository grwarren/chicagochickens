module OrdersHelper
  def units(product)
    product.unit.empty? ? '' : "(#{product.unit})"
  end

  def quantity_options_for(product)
    (0..10).to_a.collect { | n | [" #{n} #{product.unit.pluralize}", n ] }
  end
end
