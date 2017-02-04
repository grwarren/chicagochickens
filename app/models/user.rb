class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :user_id, type: Integer
  field :name, type: String
  field :email, type: String
  field :pickup_location, type: String

  field :password_digest, :type => String
  has_secure_password

  has_many :orders

  validates_presence_of :user_id, :name, :email, :pickup_location
  validates_uniqueness_of :user_id, :email

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
