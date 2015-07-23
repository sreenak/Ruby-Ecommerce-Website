class CustomisedDress < ActiveRecord::Base
  belongs_to :user
  belongs_to :dress

  mount_uploader :angle_0, CustomisedDressAngleUploader
  mount_uploader :angle_90, CustomisedDressAngleUploader
  mount_uploader :angle_180, CustomisedDressAngleUploader
  mount_uploader :angle_270, CustomisedDressAngleUploader

  validates_presence_of :user_id, :dress_id
end
