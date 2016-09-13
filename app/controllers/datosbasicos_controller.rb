class DatosbasicosController < ApplicationController
  before_action :set_datosbasico, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @datosbasicos = Datosbasico.paginate(:page => params[:page]).order("titulo")
    respond_with(@datosbasicos)
  end

  def show
    respond_with(@datosbasico)
  end

  def new
    @datosbasico = Datosbasico.new
    respond_with(@datosbasico)
  end

  def edit
  end

  def create
    @datosbasico = Datosbasico.new(datosbasico_params)
    @datosbasico.save
    respond_with(@datosbasico)
  end

  def update
    @datosbasico.update(datosbasico_params)
    respond_with(@datosbasico)
  end

  def destroy
    @datosbasico.destroy
    respond_with(@datosbasico)
  end

  private
    def set_datosbasico
      @datosbasico = Datosbasico.find(params[:id])
    end

    def datosbasico_params
      params.require(:datosbasico).permit(:titulo, :seccion, :descripcion)
    end
end
