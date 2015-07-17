class CreateAuthIdentities < ActiveRecord::Migration
  def change
    create_table :auth_identities do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :token
      t.datetime :expires_on
      t.text :params

      t.timestamps null: false
    end
  end
end
