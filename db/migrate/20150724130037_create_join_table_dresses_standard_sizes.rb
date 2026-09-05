class CreateJoinTableDressesStandardSizes < ActiveRecord::Migration
  def change
    create_join_table :dresses, :standard_sizes do |t|
      # t.index [:dress_id, :standard_size_id]
      # t.index [:standard_size_id, :dress_id]
    end
  end
end
