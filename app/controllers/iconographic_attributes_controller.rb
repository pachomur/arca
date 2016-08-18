class IconographicAttributesController < ApplicationController
  before_action :set_iconographic_attribute, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /iconographic_attributes
  # GET /iconographic_attributes.json
  def index
    @iconographic_attributes = IconographicAttribute.all.paginate(page: params[:page], per_page: 50).order('name ASC')
  end

  # GET /iconographic_attributes/1
  # GET /iconographic_attributes/1.json
  def show
  end

  # GET /iconographic_attributes/new
  def new
    @iconographic_attribute = IconographicAttribute.new
  end

  # GET /iconographic_attributes/1/edit
  def edit
  end

  # POST /iconographic_attributes
  # POST /iconographic_attributes.json
  def create
    @iconographic_attribute = IconographicAttribute.new(iconographic_attribute_params)

    respond_to do |format|
      if @iconographic_attribute.save
        format.html { redirect_to @iconographic_attribute, notice: 'Iconographic attribute was successfully created.' }
        format.json { render :show, status: :created, location: @iconographic_attribute }
      else
        format.html { render :new }
        format.json { render json: @iconographic_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /iconographic_attributes/1
  # PATCH/PUT /iconographic_attributes/1.json
  def update
    respond_to do |format|
      if @iconographic_attribute.update(iconographic_attribute_params)
        format.html { redirect_to @iconographic_attribute, notice: 'Iconographic attribute was successfully updated.' }
        format.json { render :show, status: :ok, location: @iconographic_attribute }
      else
        format.html { render :edit }
        format.json { render json: @iconographic_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /iconographic_attributes/1
  # DELETE /iconographic_attributes/1.json
  def destroy
    @iconographic_attribute.destroy
    respond_to do |format|
      format.html { redirect_to iconographic_attributes_url, notice: 'Iconographic attribute was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iconographic_attribute
      @iconographic_attribute = IconographicAttribute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def iconographic_attribute_params
      params.require(:iconographic_attribute).permit(:name)
    end
end
