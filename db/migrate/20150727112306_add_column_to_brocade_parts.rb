class AddColumnToBrocadeParts < ActiveRecord::Migration
  def change
    add_money :brocade_parts, :price
  end
end
