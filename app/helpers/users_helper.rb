module UsersHelper

  def build_user_path(user)
    user.nil? ? orders_path : user_orders_path(user)
  end

  def user_orders_headers(user)
    user.nil? ? "Current Orders" :  "Current Orders for #{user.name}"
  end
end
