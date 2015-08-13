class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  scope :active, -> {where(active: true)}
  validates_presence_of :message
end
