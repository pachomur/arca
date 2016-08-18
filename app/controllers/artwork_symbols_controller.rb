class ArtworkSymbolsController < ApplicationController
  before_action :set_artwork_symbol, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /artwork_symbols
  # GET /artwork_symbols.json
  def index
    @artwork_symbols = ArtworkSymbol.all.paginate(page: params[:page], per_page: 50).order('name ASC')
  end

  # GET /artwork_symbols/1
  # GET /artwork_symbols/1.json
  def show
  end

  # GET /artwork_symbols/new
  def new
    @artwork_symbol = ArtworkSymbol.new
  end

  # GET /artwork_symbols/1/edit
  def edit
  end

  # POST /artwork_symbols
  # POST /artwork_symbols.json
  def create
    @artwork_symbol = ArtworkSymbol.new(artwork_symbol_params)

    respond_to do |format|
      if @artwork_symbol.save
        format.html { redirect_to @artwork_symbol, notice: 'Artwork symbol was successfully created.' }
        format.json { render :show, status: :created, location: @artwork_symbol }
      else
        format.html { render :new }
        format.json { render json: @artwork_symbol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artwork_symbols/1
  # PATCH/PUT /artwork_symbols/1.json
  def update
    respond_to do |format|
      if @artwork_symbol.update(artwork_symbol_params)
        format.html { redirect_to @artwork_symbol, notice: 'Artwork symbol was successfully updated.' }
        format.json { render :show, status: :ok, location: @artwork_symbol }
      else
        format.html { render :edit }
        format.json { render json: @artwork_symbol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artwork_symbols/1
  # DELETE /artwork_symbols/1.json
  def destroy
    @artwork_symbol.destroy
    respond_to do |format|
      format.html { redirect_to artwork_symbols_url, notice: 'Artwork symbol was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork_symbol
      @artwork_symbol = ArtworkSymbol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artwork_symbol_params
      params[:artwork_symbol].permit(:name)
    end
end
