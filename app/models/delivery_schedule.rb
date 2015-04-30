class DeliverySchedule
  include Mongoid::Document
  field :date, type: Date

  validates_presence_of :date
end
