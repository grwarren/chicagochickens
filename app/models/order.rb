class Order
  include Comparable
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :delivery_date, type: Date
  field :user_name, type: String
  field :product_name, type: String

  belongs_to :user

  validates_presence_of :user, :quantity, :user_name, :product_name

end
