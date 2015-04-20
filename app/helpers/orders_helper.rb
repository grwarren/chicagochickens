module OrdersHelper
  def units(product)
    product.unit.empty? ? '' : "(#{product.unit})"
  end
end
