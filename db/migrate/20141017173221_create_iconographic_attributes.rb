class CreateIconographicAttributes < ActiveRecord::Migration
  def change
    create_table :iconographic_attributes do |t|
      t.text :name
      t.belongs_to :artwork
      t.timestamps
    end
  end
end
