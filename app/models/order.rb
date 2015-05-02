class Order
  include Comparable
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :delivery_date, type: Date
  field :user_name, type: String

  belongs_to :user
  embeds_one :product

  accepts_nested_attributes_for :product

  validates_presence_of :product, :user, :quantity

  def <=>(other)
    # use Array#<=> to compare the attributes
    [self.product.sort_order] <=> [other.product.sort_order]
  end
end
