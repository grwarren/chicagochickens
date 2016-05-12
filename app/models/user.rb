class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer
  field :name, type: String
  field :pickup_location, type: String

  has_many :orders

  validates_presence_of :name, :user_id, :pickup_location
  validates_uniqueness_of :user_id

  accepts_nested_attributes_for :orders

  def to_param
    user_id.to_s
  end

  def to_product_map
    product_map = {}
    orders.map(&:product).uniq.each do |product|
      product_map[product.name] = {}
    end

    orders.each do |order|
      product_map[order.product.name][order.delivery_date] = order.quantity
    end
    product_map
  end
end
