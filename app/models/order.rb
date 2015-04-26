class Order

  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :delivery_date, type:  Date

  belongs_to :user
  embeds_one :product

  accepts_nested_attributes_for  :product

  validates_presence_of :product, :user, :quantity
end
