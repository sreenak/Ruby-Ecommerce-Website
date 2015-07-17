class Category < ActiveRecord::Base
  extend FriendlyId
  has_many :dresses

  validates_presence_of :name

  friendly_id :name
end
