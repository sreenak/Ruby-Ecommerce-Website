class Fabric < ActiveRecord::Base
  has_many :fabric_colors
  validates_presence_of :name
end
