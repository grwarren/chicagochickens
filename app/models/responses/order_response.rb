module Responses
  class OrderResponse
    include ActiveAttr::Model

    attribute :user
    validates_presence_of :user

    def orders
      if valid?
         users_orders = user.orders.where(delivery_date: delivery_date)

         new_orders = products.collect { | product | Order.new(user: user, product: product, quantity: 0, delivery_date: delivery_date, user_name: user.name) }
         users_orders + new_orders
       else
         []
      end
    end

  private
    def products
      Product.nin(id: user.orders.map(&:product))
    end

    def delivery_date
      DeliverySchedule.last.date
    end
  end
end
