class CreateGephis < ActiveRecord::Migration
  def change
    create_table :gephis do |t|
      t.string :nombregrafo
      t.string :ubicacion
      t.integer :grafo_id

      t.timestamps
    end
  end
end
