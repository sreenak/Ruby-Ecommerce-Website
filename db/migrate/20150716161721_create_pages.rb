class CreatePages < ActiveRecord::Migration
  def change
    create_table 'pages', force: :cascade do |t|
      t.string 'title', null: false
      t.string 'slug', null: false
      t.text 'body'
      t.timestamps null: false
    end

    add_index 'pages', ['slug'], unique: true
  end
end
