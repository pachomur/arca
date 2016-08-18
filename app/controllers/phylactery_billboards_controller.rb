class PhylacteryBillboardsController < ApplicationController
  before_action :set_phylactery_billboard, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /phylactery_billboards
  # GET /phylactery_billboards.json
  def index
    @phylactery_billboards = PhylacteryBillboard.all.paginate(page: params[:page], per_page: 50).order('name ASC')
  end

  # GET /phylactery_billboards/1
  # GET /phylactery_billboards/1.json
  def show
  end

  # GET /phylactery_billboards/new
  def new
    @phylactery_billboard = PhylacteryBillboard.new
  end

  # GET /phylactery_billboards/1/edit
  def edit
  end

  # POST /phylactery_billboards
  # POST /phylactery_billboards.json
  def create
    @phylactery_billboard = PhylacteryBillboard.new(phylactery_billboard_params)

    respond_to do |format|
      if @phylactery_billboard.save
        format.html { redirect_to @phylactery_billboard, notice: 'Phylactery billboard was successfully created.' }
        format.json { render :show, status: :created, location: @phylactery_billboard }
      else
        format.html { render :new }
        format.json { render json: @phylactery_billboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phylactery_billboards/1
  # PATCH/PUT /phylactery_billboards/1.json
  def update
    respond_to do |format|
      if @phylactery_billboard.update(phylactery_billboard_params)
        format.html { redirect_to @phylactery_billboard, notice: 'Phylactery billboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @phylactery_billboard }
      else
        format.html { render :edit }
        format.json { render json: @phylactery_billboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phylactery_billboards/1
  # DELETE /phylactery_billboards/1.json
  def destroy
    @phylactery_billboard.destroy
    respond_to do |format|
      format.html { redirect_to phylactery_billboards_url, notice: 'Phylactery billboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phylactery_billboard
      @phylactery_billboard = PhylacteryBillboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phylactery_billboard_params
      params.require(:phylactery_billboard).permit(:name)
    end
end
