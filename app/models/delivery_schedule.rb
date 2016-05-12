class DeliverySchedule
  include Mongoid::Document
  field :date, type: Date
  field :pickup_location, type: String

  validates_presence_of :date, :pickup_location
end
