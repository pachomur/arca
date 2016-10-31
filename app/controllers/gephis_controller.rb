class GephisController < ApplicationController
  def index
    @gephis = Gephi.all
    @archivo = @gephis.find(params[:archivo]).ubicacion
  end


end
