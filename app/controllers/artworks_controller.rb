require "will_paginate/array"
class ArtworksController < ApplicationController
  before_filter :authenticate_user!, except:[:index,:show]
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:edit, :new]

  # GET /artworks
  # GET /artworks.json
  def index

    if not params[:search].nil?

      if params[:search].to_s.empty?
        @artworks = Artwork.all
      else
        @artworks = Artwork.b_title(params[:search])

        s_description = Artwork.s_descriptions(params[:search])

        s_description.each do |artworkt|
          @artworks << artworkt
        end

        s_synthesis = Artwork.b_synthesis(params[:search])

        s_synthesis.each do |artworkt|
          @artworks << artworkt
        end

        b_country = Artwork.b_country(params[:search])

        b_country.each do |artworkt|
          @artworks << artworkt
        end

        b_category_1 = Artwork.b_category_1(params[:search])

        b_category_1.each do |artworkt|
          @artworks << artworkt
        end

        b_category_1 = Artwork.b_category_1(params[:search])

        b_category_1.each do |artworkt|
          @artworks << artworkt
        end

        b_category_2 = Artwork.b_category_2(params[:search])

        b_category_2.each do |artworkt|
          @artworks << artworkt
        end

        b_category_3 = Artwork.b_category_3(params[:search])

        b_category_3.each do |artworkt|
          @artworks << artworkt
        end

        b_category_4 = Artwork.b_category_4(params[:search])

        b_category_4.each do |artworkt|
          @artworks << artworkt
        end

        b_category_5 = Artwork.b_category_5(params[:search])

        b_category_5.each do |artworkt|
          @artworks << artworkt
        end

        b_comment = Artwork.b_comment(params[:search])

        b_comment.each do |artworkt|
          @artworks << artworkt
        end

        b_scene = Artwork.b_scene(params[:search])

        b_scene.each do |artworkt|
          @artworks << artworkt
        end

        b_story_types = Artwork.b_story_types(params[:search])

        b_story_types.each do |artworkt|
          @artworks << artworkt
        end

        b_author = Artwork.b_author(params[:search])

        b_author.each do |artworkt|
          @artworks << artworkt
        end
      end


        set_filters(params[:author_show], params[:authors_filter], params[:topic], params[:country], params[:nivel_id])
      page =1
      if not params[:page].nil?
        page = params[:page]
      end
      @artworks = WillPaginate::Collection.create(page,10, @artworks.length) do |pager|
        pager.replace @artworks.to_a
      end
    else
      #Seccion de busqueda
      if params[:authors] == ('true')
        if params[:authors_filter].nil?
          @authors = Author.all.order(:lastname, :name)
        else
          @authors = Author.where("LOWER(lastname) LIKE ?", "#{params[:authors_filter].downcase}%").order("lastname, name")
        end
        @authors = @authors.paginate(:per_page => 20, :page => params[:page])
      else

        #Define la cantidad de obras que se muestran en cada uno de los tipos de vistas
        buscar = true

        if not params[:topic].nil?
          params[:topic] == 'true' ? buscar = false : nil
          set_filters(params[:author_show], params[:authors_filter], nil, params[:country], params[:nivel_id])
        elsif not params[:author_show].nil?
          #params[:authors_filter] = params[:author_show]
        elsif not params[:region_show].nil?
          country=Country.where(:name =>params[:region_show])
          if country[0]
            params[:country] = country[0].id
          else
            params[:region] = "true";
            params[:region_show] = nil;
          end
        end

        if not params[:country_name].nil?
          country=Country.find_by_name(params[:country_name])
          p country
          params[:country] = country.id
        end
        if buscar
          set_filters(params[:author_show], params[:authors_filter], params[:topic], params[:country], params[:nivel_id])
          if params[:region] == ('true')
            @countries_map = Hash.new
            @json_countries = Hash.new
            @artworks.each do |artwork|
              country = artwork.origin_country
              if country != nil
                if !@countries_map[country]
                  @json_countries[country.code] = 1
                  @countries_map[country] = country
                else
                  @json_countries[country.code] += 1
                end
              end
            end
          else
            page =1

            if not params[:page].nil?
              page = params[:page]
            end
            @total = @artworks.count
            @artworks = @artworks.paginate(:page => page, :per_page=>20)
          end
        end
      end
    end
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def admin
    @artworks = Artwork.paginate(:page => params[:page]).order(sort_column + ' ' + sort_direction)
  end

  # GET /artworks/new
  def new
    @artwork = Artwork.new
    set_categories

  end

  # GET /artworks/1/edit
  def edit
  end

  # POST /artworks
  # POST /artworks.json
  def create
    @artwork = Artwork.new(artwork_params)

    @artwork.save
    if !artwork_params[:avatar].nil?
      @artwork.update_attribute(:avatar, artwork_params[:avatar])
    end

    respond_to do |format|
      if @artwork.save
        if @artwork.update(artwork_params)
          format.html { redirect_to @artwork, notice: 'Artwork was successfully created.' }
          format.json { render :show, status: :created, location: @artwork }
        else
          set_categories
          format.html { render :new }
          format.json { render json: @artwork.errors, status: :unprocessable_entity }
        end
      else
        set_categories
        format.html { render :new }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /artworks/1
  # PATCH/PUT /artworks/1.json
  def update

    custom_artwork_params = artwork_params

    delete_attributes(params, custom_artwork_params)

    if params[:id] == 'send_image'
      send_image
    else
      respond_to do |format|

        if @artwork.update(custom_artwork_params)
          format.html { redirect_to @artwork, notice: 'Artwork was successfully updated.' }
          format.json { render :show, status: :ok, location: @artwork }
        else
          set_categories
          format.html { render :edit }
          format.json { render json: @artwork.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def send_image
    artwork_id = params[:artwork][:id]
    artwork = Artwork.find(artwork_id)
    p artwork.avatar.url
    send_file Rails.public_path.to_s << artwork.avatar.url.to_s.split('?')[0]
  end

  # DELETE /artworks/1
  # DELETE /artworks/1.json
  def destroy
    @artwork.destroy
    respond_to do |format|
      format.html { redirect_to artworks_url(:parent_id => params[:parent_id] ), notice: 'Artwork was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private
  # Use callbacks to share common setup or constraints between actions.
  def sort_column
    Artwork.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def set_artwork
    if params[:id]!='send_image'
      @artwork = Artwork.find(params[:id])
    else
      @artwork = Artwork.find(params[:artwork][:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def artwork_params
    params.require(:artwork).permit(:passage_id, :color, :place_id,  :origin_country_id, :actual_country_id, :scene_id, :source_id, :origin_city_id,:character,:character_ids, :actual_city_id, :donor_id, :category_1_id, :category_2_id, :category_3_id, :category_4_id, :category_5_id,
                                    :phylactery_billboard_id,:iconographic_attribute_id, :story_type_id, :school_id,:author_id, :title, :activity, :biographic_data, :signed, :synthesis,
                                    :biographic_comment, :annotation, :avatar, :sub_image, :comment,
                                    :latitude_origin,:latitude_current,:longitude_origin,:longitude_current, :type_id,
                                    :creation_date, :annotation_date,
                                    descriptions_attributes:[:id,:description,:_destroy],
                                    body_gestures_attributes:[:id,:name,:igesto, :_destroy],
                                    author_attributes:[:id,:name,:_destroy],
                                    iconographic_attribute_attributes:[:id,:name,:_destroy],
                                    phylactery_billboard_attributes:[:id,:name,:_destroy],
                                    artwork_symbols_attributes:[:id,:name,:_destroy],
                                    engravings_attributes:[:id,:name,:_destroy],
                                    donor_attributes:[:id,:name,:_destroy],
                                    passage_attributes:[:id,:name,:_destroy],
                                    scene_attributes:[:id,:name,:_destroy],
                                    country_attributes:[:id,:name,:_destroy],
                                    scene_attributes:[:id,:name,:_destroy],
                                    school_attributes:[:id,:name,:_destroy],
                                    source_attributes:[:id,:name,:_destroy],
                                    story_type_attributes:[:id,:name,:_destroy],
                                    type_attributes:[:id,:name,:_destroy],
                                    :description_ids=>[],:body_gesture_ids=>[],:character_ids=>[],:artwork_symbol_ids=>[],:engraving_ids=>[]
    )
  end

  #Set categories when editing artworks
  def set_categories
    @categories = Category.all
    @categories_for_select_1 = []
    @categories_for_select_2 = []
    @categories_for_select_3 = []
    @categories_for_select_4 = []
    @categories_for_select_5 = []
    @categories.each do |category|
      if(category.depth == 0)
        @categories_for_select_1 << [category.name, category.id]
      end
    end

    if @artwork
      if @artwork.category_1
        @categories = @artwork.category_1.children
        @categories.each do |category|
          @categories_for_select_2 << [category.name, category.id]
        end
      end

      if @artwork.category_2
        @categories = @artwork.category_2.children
        @categories.each do |category|
          @categories_for_select_3 << [category.name, category.id]
        end
      end

      if @artwork.category_3
        @categories = @artwork.category_3.children
        @categories.each do |category|
          @categories_for_select_4 << [category.name, category.id]
        end
      end

      if @artwork.category_4
        @categories = @artwork.category_4.children
        @categories.each do |category|
          @categories_for_select_5 << [category.name, category.id]
        end
      end
    end
  end

  #Elimina los atributos marcados desde la vista de edición
  def delete_attributes(params_hash, custom_artwork_params)
    if params_hash[:delete_passage]
      custom_artwork_params.delete :passage_id
      @artwork.passage = nil
    end

    if params_hash[:delete_country]
      custom_artwork_params.delete :country_id
      @artwork.origin_country = nil
    end

    if params_hash[:delete_scene]
      custom_artwork_params.delete :scene_id
      @artwork.scene = nil
    end

    if params_hash[:delete_type]
      custom_artwork_params.delete :type_id
      @artwork.type = nil
    end

    if params_hash[:delete_source]
      custom_artwork_params.delete :source_id
      @artwork.source = nil
    end

    if params_hash[:delete_donor]
      custom_artwork_params.delete :donor_id
      @artwork.donor = nil
    end

    if params_hash[:delete_iconographic_attribute]
      custom_artwork_params.delete :iconographic_attribute_id
      @artwork.iconographic_attribute = nil
    end

    if params_hash[:delete_phylactery_billboard]
      custom_artwork_params.delete :phylactery_billboard_id
      @artwork.phylactery_billboard = nil
    end

    if params_hash[:delete_story_type]
      custom_artwork_params.delete :story_type_id
      @artwork.story_type = nil
    end

    if params_hash[:delete_school]
      custom_artwork_params.delete :school_id
      @artwork.school = nil
    end
  end


  # Methods to set @artworks, @clasifications, @countries, @authors
  def set_filters author_id, author_lastname, category_id, country_id, nivel_id
    if nivel_id == nil then nivel_id = 1
    elsif nivel_id.split("/").size == 1 then nivel_id = 2
    elsif nivel_id.split("/").size == 2 then nivel_id = 3
    elsif nivel_id.split("/").size == 3 then nivel_id = 4
    else nivel_id = 5
    end
    if not params[:search].nil? and not params[:search].to_s.empty?
      p "Filter artworks..."
      @clasifications = Category.filtros_category(author_id, author_lastname, category_id, country_id, nivel_id)
      @countries = Country.filtros_place(author_id, author_lastname, category_id, country_id, nivel_id)
    else
      @clasifications = Category.filtros_category(author_id, author_lastname, category_id, country_id, nivel_id)
      @countries = Country.filtros_place(author_id, author_lastname, category_id, country_id, nivel_id)
      @artworks = Artwork.filtros(author_id, author_lastname, category_id, country_id, nivel_id)
    end
    @clasifications.parent = Category.find(params[:parent_id]) unless params[:parent_id] == nil
  end

end