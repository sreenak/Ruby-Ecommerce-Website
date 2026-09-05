class AddPriceToEmbelishmentParts < ActiveRecord::Migration
  def change
    add_money :embellishment_parts, :price
  end
end
