class Address < ActiveRecord::Base
  validates_presence_of :address_1, :city, :country
  belongs_to :addressable, polymorphic: true
end
