class Category < ActiveRecord::Base
  extend FriendlyId
  has_many :dresses
  has_many :products
  
  validates_presence_of :name

  friendly_id :name
end
