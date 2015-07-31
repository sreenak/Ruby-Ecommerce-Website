class CreateJoinTableBrocadePartsEmbellishments < ActiveRecord::Migration
  def change
    create_join_table :brocade_parts, :embellishments do |t|
      # t.index [:brocade_part_id, :embellishment_id]
      # t.index [:embellishment_id, :brocade_part_id]
    end
  end
end
