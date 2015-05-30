module UsersHelper

  def build_user_path(user)
    user.nil? ? orders_path : user_orders_path(user)
  end

  def build_edit_path(user_id, delivery_date)
    "orders/edit?deliveryDate=#{delivery_date}"
  end

  def user_orders_headers(user)
    user.nil? ? "Orders" :  "Orders for #{user.name}"
  end
end
