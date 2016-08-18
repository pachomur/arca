class EngravingsController < ApplicationController
  before_action :set_engraving, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /engravings
  # GET /engravings.json
  def index
    @engravings = Engraving.all.paginate(page: params[:page], per_page: 50).order('name ASC')
  end

  # GET /engravings/1
  # GET /engravings/1.json
  def show
  end

  # GET /engravings/new
  def new
    @engraving = Engraving.new
  end

  # GET /engravings/1/edit
  def edit
  end

  # POST /engravings
  # POST /engravings.json
  def create
    @engraving = Engraving.new(engraving_params)

    respond_to do |format|
      if @engraving.save
        format.html { redirect_to @engraving, notice: 'Engraving was successfully created.' }
        format.json { render :show, status: :created, location: @engraving }
      else
        format.html { render :new }
        format.json { render json: @engraving.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /engravings/1
  # PATCH/PUT /engravings/1.json
  def update
    respond_to do |format|
      if @engraving.update(engraving_params)
        format.html { redirect_to @engraving, notice: 'Engraving was successfully updated.' }
        format.json { render :show, status: :ok, location: @engraving }
      else
        format.html { render :edit }
        format.json { render json: @engraving.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engravings/1
  # DELETE /engravings/1.json
  def destroy
    @engraving.destroy
    respond_to do |format|
      format.html { redirect_to engravings_url, notice: 'Engraving was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engraving
      @engraving = Engraving.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engraving_params
      params.require(:engraving).permit(:name)
    end
end
