class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  scope :active, -> {where(active: true)}
end
