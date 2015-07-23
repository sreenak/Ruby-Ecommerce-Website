class CustomSize < ActiveRecord::Base
  has_and_belongs_to_many :dresses
  validates_presence_of :name, :size, :unit
end
