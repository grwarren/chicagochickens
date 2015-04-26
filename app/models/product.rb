class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :unit, type: String

  validates_presence_of :name
end
