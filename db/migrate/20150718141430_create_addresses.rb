class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :type, default: '', null: false
      t.belongs_to :addressable, index: true, polymorphic: true
      t.string :name, default: '', null: false
      t.string :address_1, default: '', null: false
      t.string :address_2
      t.string :country, default: '', null: false
      t.string :state
      t.string :city, default: '', null: false
      t.string :postal_code

      t.timestamps null: false
    end
  end
end
