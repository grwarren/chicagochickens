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
      Order.new(quantity: params[:quantity], user: params[:user], product: product, delivery_date: params[:delivery], user_name: params['user.name'])
    end

  private
    def product
      Product.find_by(id: params[:product]) rescue nil
    end

    def product_exists?
      errors.add(:product, "does not exist") if product.nil?
    end

    def params_completeness?
      errors.add(:user, "is not known") if params[:user].nil?
    end
  end
end
