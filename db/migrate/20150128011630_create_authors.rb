class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :lastname
      t.text :biography
      t.text :activity
      t.string :avatar_file_name
      t.timestamps
    end
  end
end