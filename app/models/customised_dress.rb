class CustomisedDress < ActiveRecord::Base
  belongs_to :user
  belongs_to :dress

  mount_uploader :image, ImageUploader

  validates_presence_of :user_id, :dress_id
end
