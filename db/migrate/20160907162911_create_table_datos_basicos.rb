class CreateTableDatosBasicos < ActiveRecord::Migration
  def change
    create_table :datos_basicos do |t|
      t.string :titulo
      t.string :seccion
      t.text :description
    end
  end
end
