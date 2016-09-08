class CreateDatosbasicos < ActiveRecord::Migration
  def change
    create_table :datosbasicos do |t|
      t.string :titulo
      t.string :seccion
      t.text :descripcion

      t.timestamps
    end
  end
end
