class BrocadePart < ActiveRecord::Base
  belongs_to :brocade
  belongs_to :part
end
