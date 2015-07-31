class RemoveNameEmailFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :name, :string
    remove_column :reviews, :email, :string
  end
end
