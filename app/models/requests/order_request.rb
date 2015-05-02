module Requests
  class OrderRequest
    include ActiveAttr::Model

    attribute :params
    validates :params, presence: true
    validate :product_exists?
    validate :params_completeness?

    def save
      valid? && order.save
    end

    def order
      user =  params[:user]
      Order.new(quantity: params[:quantity], user: user, product: product, delivery_date: params[:delivery], user_name: user_name(user))
    end

  private
    def product
      Product.find_by(id: params[:product]) rescue nil
    end

    def user_name(user)
      user.nil? ? "" : user.name
    end

    def product_exists?
      errors.add(:product, "does not exist") if product.nil?
    end

    def params_completeness?
      errors.add(:user, "is not known") if params[:user].nil?
    end
  end
end
