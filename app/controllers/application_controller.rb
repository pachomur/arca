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
      case dato.id
        when 1
          @tproyecto = dato.titulo
          @proyecto = dato.descripcion
        when 2
          @tproposito = dato.titulo
          @proposito = dato.descripcion
        when 3
          @tespacio = dato.titulo
          @espacio = dato.descripcion
        when 4
          @tconjunto = dato.titulo
          @conjunto = dato.descripcion
        when 5
          @tlegal = dato.titulo
          @legal = dato.descripcion
        when 6
          @tcitacion = dato.titulo
          @citacion = dato.descripcion
      end
    end
  end

end
