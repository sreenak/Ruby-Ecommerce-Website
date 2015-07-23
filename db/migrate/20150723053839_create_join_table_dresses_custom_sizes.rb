class CreateJoinTableDressesCustomSizes < ActiveRecord::Migration
  def change
    create_join_table :dresses, :custom_sizes do |t|
      # t.index [:dress_id, :custom_size_id]
      # t.index [:custom_size_id, :dress_id]
    end
  end
end
