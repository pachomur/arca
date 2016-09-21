class Passage < ActiveRecord::Base
  validates_presence_of :name, :message => "Tiene que ingresar un nombre para el pasaje."
  validates :name, uniqueness: { case_sensitive: false , message: "Ya existe un pasaje con el mismo nombre" }

  has_many :artworks


  def get_history_type
    history_type ? history_type : "N/A"
  end


end
