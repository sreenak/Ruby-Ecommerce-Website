class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  def display_name
    @display_name || name.titlecase
  end
end
