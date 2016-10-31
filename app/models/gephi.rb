class Gephi < ActiveRecord::Base

  validates_presence_of :nombregrafo, :message => "Tiene que ingresar un nombre para el grafo."
  validates_presence_of :ubicacion, :message => "Tiene que ingresar una ubicacion del archivo."

  def gephi_params
    params.require(:gephi).permit(:nombregrafo, :ubicacion, grafo_id, created_at, updated_at)
  end

end
