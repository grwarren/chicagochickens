class Order

  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :delivery_date, type:  Date
  field :delivered, type: Boolean

  belongs_to :user
  has_one :product
end
