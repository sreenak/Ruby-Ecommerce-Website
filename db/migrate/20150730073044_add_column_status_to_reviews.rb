class AddColumnStatusToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :active, :boolean
  end
end
