class Page < ActiveRecord::Base
  include FriendlyId
  include Authority::Abilities
  self.authorizer_name = 'AdminAuthorizer'

  friendly_id :title, :use => [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? or title_changed?
  end
end
