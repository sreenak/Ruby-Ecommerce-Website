class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates_presence_of :message

  default_scope -> {order(created_at: :desc)}
  scope :active, -> {where(active: true)}


  private
  def user_avatar user
    if user.image.present?
      image_tag user.image_url :thumbnail
    else
      image_tag 'default.png'
    end
  end
end
