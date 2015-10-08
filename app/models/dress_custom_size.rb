class DressCustomSize < ActiveRecord::Base
  belongs_to :line_item
  validates_presence_of :chest, :waist, :length, :shoulder, :arm_hole, :neck
end
