class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :unit, type: String

  belongs_to :order
end
