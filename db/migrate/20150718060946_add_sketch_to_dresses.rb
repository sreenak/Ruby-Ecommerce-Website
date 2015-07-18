class AddSketchToDresses < ActiveRecord::Migration
  def change
    add_column :dresses, :sketch, :string, default: '', null: false
  end
end
