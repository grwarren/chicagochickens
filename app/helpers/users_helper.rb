module UsersHelper

  def build_user_path(user)
    user.nil? ? orders_path : user_orders_path(user)
  end
end
