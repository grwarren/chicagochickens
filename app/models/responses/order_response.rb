module Responses
  class OrderResponse
    include ActiveAttr::Model

    attribute :user
    validates_presence_of :user

    def orders
      if valid?
        all_orders = []
        delivery_dates.each do |delivery_date|
          users_orders = user.orders.where(delivery_date: delivery_date)
          new_orders = products_for(users_orders).collect { | product | Order.new(user: user, product: product, quantity: 0, delivery_date: delivery_date, user_name: user.name) }
          all_orders += users_orders + new_orders
        end
        all_orders
      else
        []
      end
    end

  private
    def products_for(users_orders)
      Product.nin(id: users_orders.map(&:product))
    end

    def delivery_dates
      DeliverySchedule.all.order_by(:date.desc).map(&:date)
    end
  end
end
