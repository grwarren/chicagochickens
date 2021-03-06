class Product
  include Comparable
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :unit, type: String
  field :price, type: Integer
  field :sort_order, type: Integer

  validates_presence_of :name, :unit, :price

  def <=>(other)
    # use Array#<=> to compare the attributes
    [self.sort_order] <=> [other.sort_order]
  end

end
