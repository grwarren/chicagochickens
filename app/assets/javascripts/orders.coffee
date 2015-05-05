# is for id, . is for class
$(document).ready ->

  order_count = $(".orders tr" ).size()
  product_name = ''
  current_product_total = 0
  $(".orders tr" ).each (index, order) ->
    if (index == 0)
      return

    if (index == 1)
      product_name = $(order).children(".product_name").text()
      console.log(product_name)
    else
      next_product_name = $(order).children(".product_name").text()
      if (next_product_name == product_name)
        same_product($(order))
      else
        product_name = next_product_name
        console.log(product_name)
        next_product($(order), current_product_total)
        current_product_total = 0

    current_product_total += parseInt($(order).children(".quantity").text())
    console.log(current_product_total)

#    Don't forget final total
    if (index + 1 == order_count)
      last_product($(order), current_product_total)

  return

same_product = (order) ->
  order.children(".delivery_date").text("")
  order.children(".product_name").text("")
  return

next_product = (order, total) ->
  order.before("<tr class=\"totals\"><th></th><th></th><th>Total</th><th>" + total + "</th></tr>")

last_product = (order, total) ->
  order.after("<tr class=\"totals\"><th></th><th></th><th>Total</th><th>" + total + "</th></tr>")
