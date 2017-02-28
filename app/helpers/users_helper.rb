module UsersHelper

  def build_edit_path(delivery_date)
    "orders/edit?deliveryDate=#{delivery_date}"
  end

  def user_orders_headers(user)
    user.nil? ? "Orders" : "Orders for #{user.name}"
  end
end
