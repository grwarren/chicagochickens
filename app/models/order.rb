class Order
  include Comparable
  include Mongoid::Document
  include Mongoid::Timestamps

  field :delivery_date, type: Date
  field :user_name, type: String

  embeds_many(:order_items)
  belongs_to :user

  validates_presence_of :user, :delivery_date, :user_name
  accepts_nested_attributes_for :order_items

end
