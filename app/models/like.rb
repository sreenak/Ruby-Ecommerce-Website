class Like < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :product, dependent: :destroy
end
