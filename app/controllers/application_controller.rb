class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_datos_basicos
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def set_datos_basicos
    @datobasicos = Datosbasico.all
    @datobasicos.each do |dato|
      case dato.titulo
        when "Proyecto"
          @proyecto = dato.descripcion
        when "Proposito"
          @proposito = dato.descripcion
        when "Espacio"
          @espacio = dato.descripcion
        when "Conjunto"
          @conjunto = dato.descripcion
        when "Legal"
          @legal = dato.descripcion
        when "Citacion"
          @citacion = dato.descripcion
      end
    end
  end

end
