class Post < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title
  validates_presence_of :title, :image, :body
  mount_uploader :image, ImageUploader

  def should_generate_new_friendly_id?
    slug.blank? or title_changed?
  end

  default_scope -> {order created_at: :desc}
  scope :featured, -> {where featured: true}
  scope :regular, -> {where featured: false}
end
