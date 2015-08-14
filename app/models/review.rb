class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  scope :active, -> {where(active: true)}
  validates_presence_of :message

  private

  def user_avatar user
    if user.image.present?
      image_tag user.image_url :thumbnail
    else
      image_tag 'default.png'
    end
  end
end
