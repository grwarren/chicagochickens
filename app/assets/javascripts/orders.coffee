# is for id, . is for class
$(document).ready ->
  $(".order-minus-btn").click (e) ->
    changeElementValue(this, decrement)
    e.preventDefault

  $(".order-plus-btn").click (e) ->
    changeElementValue(this, increment)
    e.preventDefault

  order_count = $(".orders tr" ).length
  product_name = ''
  current_product_total = 0
  $(".orders tr" ).each (index, order) ->
    if (index == 0)
      return

    if (index == 1)
      product_name = $(order).children(".product_name").text()
    else
      next_product_name = $(order).children(".product_name").text()
      if (next_product_name == product_name)
        same_product($(order))
      else
        product_name = next_product_name
        next_product($(order), current_product_total)
        current_product_total = 0

    current_product_total += parseInt($(order).children(".quantity").text())

    # Don't forget final total
    if (index + 1 == order_count)
      last_product($(order), current_product_total)
  return

changeElementValue = (element, appliedFunc) ->
  inputField = $(element).parents("td").find('input[type="text"]').first()
  value = inputField.val()
  inputField.val(appliedFunc(value))

increment = (val) ->
  result = parseInt(val) + 1
  if result <= 6 then result else alert('Limit 6 per person'); 6;

decrement = (val) ->
  result = parseInt(val) - 1
  if result >= 0 then result else 0

same_product = (order) ->
  order.children(".delivery_date").text("")
  order.children(".product_name").text("")
  return

next_product = (order, total) ->
  order.before("<tr class=\"totals\"><th></th><th></th><th>Total</th><th>" + total + "</th></tr>")

last_product = (order, total) ->
  order.after("<tr class=\"totals\"><th></th><th></th><th>Total</th><th>" + total + "</th></tr>")
