namespace :loader do
  require 'csv'

  @ruta_imagenes = '/arca/project/imagenes/'
  #@ruta_imagenes = '/home/kelvin/Documents/Historia/imagenes_jaime/base/'
  @ruta_imagenes2 = '/arca/project/imagenesBase2/'
  @ruta_imagenes_gestos = '/Portal ARCA/project/imagenesGestos/'

  desc "Solo autores"
  task load_authors_with_lastname: :environment do
    p "Solo autores"
    Rake::Task['loader:load_autores'].invoke
    Rake::Task['loader:load_autores_apellido'].invoke
  end

  desc "carga general"
  task load_categorias: :environment do
    p "carga general"
    Rake::Task['loader:load_categories1'].invoke
  end

  desc "carga general"
  task load_general_test: :environment do
    p "carga general"
    Rake::Task['loader:load_countries'].invoke
    Rake::Task['loader:load_categories1'].invoke
    Rake::Task['loader:load_autores'].invoke
    Rake::Task['loader:load_tecnica'].invoke
    Rake::Task['loader:load_fuente'].invoke
    Rake::Task['loader:load_personajes_relato'].invoke
    Rake::Task['loader:passages_csv'].invoke
    Rake::Task['loader:load_obras'].invoke

  end

  desc "carga general"
  task load_general: :environment do
    p "carga general"
    Rake::Task['loader:load_countries'].invoke
    Rake::Task['loader:load_categories1'].invoke
    Rake::Task['loader:load_autores'].invoke
    Rake::Task['loader:load_tecnica'].invoke
    Rake::Task['loader:load_fuente'].invoke
    Rake::Task['loader:load_personajes_relato'].invoke
    Rake::Task['loader:passages_csv'].invoke
    Rake::Task['loader:load_obras_base1'].invoke
    Rake::Task['loader:load_autores_apellido'].invoke


  end

  desc "Loads the whole 2nd database to the application"
  task load_second_db: :environment do
    Rake::Task['loader:load_personajes_relato'].invoke
    Rake::Task['loader:load_characters'].invoke
    Rake::Task['loader:load_countries'].invoke
    Rake::Task['loader:load_categories1'].invoke
    Rake::Task['loader:load_autores'].invoke
    Rake::Task['loader:load_tecnica'].invoke
    Rake::Task['loader:load_fuente'].invoke
    Rake::Task['loader:passages_csv'].invoke
    
    Rake::Task['loader:load_symbols'].invoke
    Rake::Task['loader:load_descriptors'].invoke
    Rake::Task['loader:load_db_two'].invoke
    Rake::Task['loader:load_desc_obras'].invoke
    Rake::Task['loader:load_simb_obras'].invoke

    Rake::Task['loader:reset_table_sequences'].invoke
    Rake::Task['loader:load_obras_base1'].invoke
    Rake::Task['loader:load_personajes_obras'].invoke
    Rake::Task['loader:load_autores_apellido'].invoke
    Rake::Task['loader:load_lugares_obras_DB2'].invoke
    Rake::Task['loader:load_author_data'].invoke

  end

  desc "Loads the countries listed in countries.csv into the countries table"
  task load_countries: :environment do
  	file = File.join(Rails.root, 'app', 'assets', 'data', 'countries.csv')
  	lines = File.new(file).readlines
  	lines.each do |line|
		  values = line.strip.split(',')
		  attributes = {"code" => values[1], "name" => values[2], "name_spanish" => values[3]}
		  Country.create(attributes)

		end
  end

  desc "Loads the category level 0 listed in cate1.csv into the Category table"
  task load_categories1: :environment do
  	p "categorias base"
    file = File.join(Rails.root, 'app', 'assets', 'data', 'c1.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      if not row['Categorías 1'].nil?
		    attributes = {"name" => row['Categorías 1']}
        Category.create(attributes)
      end
    end
    Rake::Task['loader:load_categories12'].invoke

  end

  desc "Loads the category level 0 listed in cate1.csv into the Category table"
  task load_categories12: :environment do
    p "categorias 12"
    file = File.join(Rails.root, 'app', 'assets', 'data', 'c1-2.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      base_all = Category.where(:name=>row['Categoría 1'])
      base_all.each do|base|
          #p row['Categoría 1']
          #p base.depth
          if(base.depth == 0)
            #p "entro"
            attributes = {"name" => row['Categorías 2']}
            a = Category.new(attributes)
            a.parent = base
            a.save
            break
        end
      end
    end
    Rake::Task['loader:load_categories23'].invoke

  end

  desc "Loads the category level 0 listed in cate1.csv into the Category table"
  task load_categories23: :environment do
    p "categorias 23"

    file = File.join(Rails.root, 'app', 'assets', 'data', 'c2-3.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|

      base_all = Category.where(:name=>row['Categoría 2'])
      base_all.each do|base|
          if(base.depth == 1)
            attributes = {"name" => row['Categoría 3']}
            a = Category.new(attributes)
            a.parent = base
            a.save
            break
        end
      end
    end
    Rake::Task['loader:load_categories34'].invoke
  end

  desc "Loads the category level 0 listed in cate1.csv into the Category table"
  task load_categories34: :environment do
    p "categorias 34"

    file = File.join(Rails.root, 'app', 'assets', 'data', 'c3-4.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|

      base_all = Category.where(:name=>row['Categoría 3'])
      base_all.each do|base|
          if(base.depth == 2)
            attributes = {"name" => row['Categoría 4']}
            a = Category.new(attributes)
            a.parent = base
            a.save
            break
        end
      end
    end
    Rake::Task['loader:load_categories45'].invoke

  end

  desc "Loads the category level 0 listed in cate1.csv into the Category table"
  task load_categories45: :environment do
    p "cate45"

    file = File.join(Rails.root, 'app', 'assets', 'data', 'c4-5.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|

      base_all = Category.where(:name=>row['Categoría 4'])
      base_all.each do|base|
          if(base.depth == 3)
            attributes = {"name" => row['Categoría 5']}
            a = Category.new(attributes)
            a.parent = base
            a.save
            break
        end
      end
		end
  end

  desc "Autores"
  task load_autores: :environment do
    p "Autores"

    file = File.join(Rails.root, 'app', 'assets', 'data', 'autor_carga.csv')
    lines = File.new(file).readlines
      lines.each do |line|
        values = line.strip.split(',')
        nombre = values[0]
        nombre.strip!
        attributes = {"name" => nombre}
        Author.create(attributes)
      end
  end

  desc "tecnica"
  task load_tecnica: :environment do
    p "Tecnica"
    file = File.join(Rails.root, 'app', 'assets', 'data', 'tecnica.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      tipo = row['Tipo']
      id = row['ID']
      
      attributes = {"name" => tipo, "id" => id}
      Type.create(attributes)
    end
  end

  desc "fuente"
  task load_fuente: :environment do
    p "fuente"

    file = File.join(Rails.root, 'app', 'assets', 'data', 'fuente.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      attributes = {"id" => row['ID'], "name" => row['Fuente']}
      Source.create(attributes)
    end

  end

  desc "Obras ficticias"
  task load_obras: :environment do
    p "Obras"

    file = File.join(Rails.root, 'app', 'assets', 'data', 'obras.csv')
    lines = File.new(file).readlines
    i = 0
    lines.each do |line|
      i= i+1
      values = line.strip.split(',')
      attributes = {"title" => values[0],
                    "activity" => values[1],
                    "biographic_data" => values[2],
                    "synthesis" => values[3],
                    "biographic_comment" => values[4],
                    "annotation" => values[5],
                    "comment" => values[7],
                    "latitude_origin" => values[8],
                    "latitude_current" => values[9],
                    "longitude_origin" => values[10],
                    "longitude_current" => values[11]
                    }
      autor = Author.find(i)
      if autor.nil?
        autor =Author.first
      end
      a = Artwork.new(attributes)
      a.author = autor

      pla = Country.find(i)
      if pla.nil?
        pla = Country.first
      end
      a.origin_country = pla

      cat = Category.find(i)
      if cat.nil?
        cat =Author.first
      end
      a.category_1= cat
      cat2 = cat.children.first
      if not cat2.nil?
        a.category_2= cat2
      end
      a.engravings.new(:name=>"kelvin")

      desc = Description.find(i)
      if desc.nil?
        desc= Description.first
        end

      desc2 = Description.find(i+1)
      if desc2.nil?
        desc2= Description.first
      end

      desc3 = Description.find(i+2)
      if desc3.nil?
        desc3 = Description.first
      end

      a.descriptions<<desc

      a.descriptions<<desc2
      a.descriptions<<desc3

      sym = ArtworkSymbol.find(i)
      if sym.nil?
        sym= ArtworkSymbol.first
      end

      sym2 = ArtworkSymbol.find(i+1)
      if sym2.nil?
        sym2= ArtworkSymbol.first
      end

      sym3 = ArtworkSymbol.find(i+2)
      if sym3.nil?
        sym3 = ArtworkSymbol.first
      end

      a.artwork_symbols<<sym
      a.artwork_symbols<<sym2
      a.artwork_symbols<<sym3

      a.save!
    end
  end

  desc "Personajes Relato"
  task load_personajes_relato: :environment do
    p "Personajes relato"

    file = File.join(Rails.root, 'app', 'assets', 'data', 'personajes_relato.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      if not row['Fecha de beatificación'].nil?
        beat_date = row['Fecha de beatificación']+"-01-01"
      else
        beat_date=nil
      end
      if not row['Fecha de muerte'].nil?
        death_date = row['Fecha de muerte']+"-01-01"
      else
        beat_date=nil
      end

      if not row['Fecha de canonización'].nil?
        cano_date = row['Fecha de canonización']+"-01-01"
      else
        cano_date=nil
      end

      attributes = {"id" => row['Id'].to_i+573,
                    "name" => row['Nombre'],
                    "biography" => row['Mini biografía'],
                    "death_date" => death_date,
                    "beatification_date" => beat_date,
                    "canonization_date" => cano_date
      }

      Character.create(attributes)
    end
  end

  desc "Load passage CSV"
  task passages_csv: :environment do
    p "Loading Passages..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'passages.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      Passage.create(:name => row['Título'],
        :id => row['Id'],
        :text => row['Pasaje'],
        :history_type => row['Tipo de historia'],
        :source => row['Fuente']
        )
    end
  end

  desc "Obras base 1"
  task load_obras_base1: :environment do
    p "Loading artworks..."
    #file = File.join(Rails.root, 'app', 'assets', 'data', 'obras_base_1.csv')
    file = File.join(Rails.root, 'app', 'assets', 'data', 'export.csv')
    i = 0
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      i = i+1
      #p i
      if i== 100
        #break
      end

      if row.length== 21
        if !/\A\d+\z/.match(row['Id'])
          break
        else

          #Escenario;
          scene = Scene.find_or_create_by(:name=>row['Escenario'])
          #TipoRelato;
          tipo_relato = StoryType.find_or_create_by(:name=>row['TipoRelato'])
          #NombreDonante;
          donante = Donor.find_or_create_by(:name=>row['NombreDonante'])
          #Cartela;
          cartela = PhylacteryBillboard.find_or_create_by(:name=>row['Cartela'])
          #Simbolos;
          #p row['Id']
          if row['Simbolos']
            #p row['Simbolos']
            s = ArtworkSymbol.where("name LIKE :prefix", prefix: "%#{row['Simbolos']}%")[0]
            simbolos = ArtworkSymbol.find_by(:name=>row['Simbolos'])
          else
            simbolos = nil
          end
          #Id Imagen;
          #Autor;
          autor = Author.find_or_create_by(:name=>row['Autor'])
          #Titulo;
          titulo = row['Titulo']
          #Fecha;
          #ComentariosBiblio;
          comentariosBiblio = row['ComentariosBiblio']
          #Técnica;
          tecnica = nil
          if row['Técnica']
            tecnica = Type.find_or_create_by(:name=>row['Técnica'])
          end
          #Fuenteimagen;
          fuente = Source.find_or_create_by(:name=>row['Fuenteimagen'])
          #País y ciudad
          pais_origen = nil
          ciudad_origen = nil
          pais_actual = nil
          if row['Ciudad']
            pais_ciudad = row['Ciudad'].split(',')
            if pais_ciudad[0]
              pais_origen = Country.find_by(:name_spanish => pais_ciudad[0].strip)
              if !pais_origen
                p "No se encontró el país #{pais_ciudad[0]}"
              end
              if pais_ciudad[1]
                if Country.find_by(:name_spanish => pais_ciudad[1].strip)
                  pais_actual = Country.find_by(:name_spanish => pais_ciudad[1].strip)
                else
                  ciudad_origen = City.find_or_create_by(:name => pais_ciudad[1].strip)
                end
              end
            end
          end
          #ciudad = Place.find_or_create_by(:name=>row['Ciudad'])
          # Lugar
          lugar = nil
          if row['ProcedenciaIm']
            lugar = Place.find_or_create_by(:name=>row['ProcedenciaIm'])
          end
          # Anotaciones;
          anotaciones = row['Anotaciones']
          # Id Relato - Personaje;
          if row['Id Relato - Personaje']
            #p "id relato"
            begin
              id = row['Id Relato - Personaje'].to_i+573
              personaje = Character.find_by(:id=>id)
              #p row['Id Relato - Personaje'].to_i+573
            rescue
              personaje = nil
              p row['Id Relato - Personaje']
              p 'Error: Id Relato - Personaje'
            end

          end
          # Id Pasaje;
          # Atributos iconográficos;
          atributos = IconographicAttribute.find_or_create_by(:name=>row['Atributos iconográficos'])
          # Personajes excluidos;
          #se cambia
          #p "personaje excluido"
          #p row['Personajes excluidos']
          personaje_excluido = Character.find_or_create_by(:name=>row['Personajes excluidos'])
          #p row['Personajes excluidos']
          # Sintesis
          sintesis = row['Sintesis']
          #p scene.id
          f_avatar = nil
          if row['Id Imagen'] && false

            if File.exist?(@ruta_imagenes+(16000+row['Id Imagen'].to_i).to_s+ '.jpg')
              #p @ruta_imagenes+(16000+row['Id Imagen'].to_i).to_s+ '.jpg'
              #se cambia
              f_avatar = File.open(@ruta_imagenes+(16000+row['Id Imagen'].to_i).to_s+ '.jpg')
            elsif File.exist?(@ruta_imagenes+(16000+row['Id Imagen'].to_i).to_s+ '.JPG')
              #p @ruta_imagenes+(16000+row['Id Imagen'].to_i).to_s+ '.JPG'
              #se cambia
              f_avatar = File.open(@ruta_imagenes+(16000+row['Id Imagen'].to_i).to_s+ '.JPG')
            else
              p "No se encontró imagen #{16000+row['Id Imagen'].to_i}"
            end
          else
            #p "No se agrego imagen"
          end

          artwork = Artwork.create(
              #:passage_id=>
              :id => (row['Id Imagen'].to_i+16000),
              #se cambia
              :avatar =>f_avatar,
              :author_id=>autor.id,
              :scene_id=>scene.id,
              :type_id => tecnica.nil? ? nil : tecnica.id,
              :source_id=>fuente.id,
              :donor_id=>donante.id,
              :iconographic_attribute_id=>atributos.id,
              :phylactery_billboard_id=>cartela.id,
              :story_type_id=>tipo_relato.id,
              :title=>titulo,
              :annotation=>anotaciones,
              :synthesis=>sintesis,
              :biographic_comment=>comentariosBiblio,
              :place=>lugar,
              :origin_country => pais_origen,
              :origin_city => ciudad_origen,
              :actual_country => pais_actual
              )
          artwork.save!
          if simbolos
            artwork.artwork_symbols << simbolos
          end
          if personaje
            artwork.characters << personaje
            artwork.characters << personaje_excluido
          end
          artwork.save!

        end
      else
        #p "tamaño"
        #p row.length
        #p "id"
        #p row['Id']
        #p "id relato"
        #p row['Id Relato - Personaje']
        break
      end
    end
  end

  desc "Autores apellidos"
  task load_autores_apellido: :environment do
    p "Autores edicion apellidos"

    file = File.join(Rails.root, 'app', 'assets', 'data', 'autores_apellido.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      obj = Author.find_by_name(row['base'])
      if obj.nil?
        Author.create(:name=> row['nombre'],:lastname => row['apellido']).save
        p "Creado: #{row['nombre']}, #{row['apellido']} de #{row['base']}"
      else
        obj.name = row['nombre']
        obj.lastname = row['apellido']
        obj.save
      end
    end
  end

  desc "Simbolos"
  task load_symbols: :environment do
    p "Importando símbolos..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'simbolos.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      symbol = row['simbolo']
      ArtworkSymbol.find_or_create_by(:name=>symbol)
    end
  end

  desc "Descriptores"
  task load_descriptors: :environment do
    p "Importando descriptores..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'descriptors.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      desc = row['descriptor']
      Description.find_or_create_by(:description=>desc)
    end
  end

  desc "Personajes"
  task load_characters: :environment do
    p "Importando personajes..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'personajes.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      id_personaje = row['ID']
      name = row['Personaje']
      biography = row['Biografia']
      death_year = row['Año Muerte'] ? "01/01/"+row['Año Muerte'] : nil
      beatification_date = row['Año Beatificación'] ? "01/01/"+row['Año Beatificación'] : nil
      canonization = row['Canonización'] ? "01/01/"+row['Canonización'] : nil

      death_date = death_year ? death_year.to_date : nil
      bea_date = beatification_date ? beatification_date.to_date : nil
      cano_date = canonization ? canonization.to_date : nil

      Character.find_or_create_by(:id=>id_personaje,:name=>name, :biography=>biography, :death_date=>death_date,
                                  :canonization_date=>cano_date, :beatification_date=>bea_date)
    end
  end

  desc "Obras base dos"
  task load_db_two: :environment do
    p "Importando obras segunda base..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'Consulta2.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      id_obras= row['ID']
      escenario = row['Escenario']
      donante = row['Donante']
      id_imagen = row['ID Imagen']
      autor = row['Autor']
      titulo = row['Título']
      comentarios_biblio = row['comentarios_biblio']
      cartelera_f = row['Cartelera Filacterias']
      tipo_de_relato = row['Tipo_De_Relato']
      tipo = row['Tipo']
      fuente_imagen = row['Fuente']
      lugar = row['lugar']
      anotaciones = row['anotaciones']
      sintesis = row['Sintesis']
      atributos_iconograficos = row['Atributos Iconograficos']
      procedencia = row['Procedencia']
      fecha = row['Fecha']

      #caregoprias
      cat0 = row['Categorías']
      cat1 = row['sub1']
      cat2 = row['sub2']
      cat3 = row['sub3']
      cat4 = row['sub4']


      #p id_obras
      #p id_imagen
      #p titulo
      if not(escenario.to_s.empty? and donante.to_s.empty? and id_imagen.to_s.empty? and autor.to_s.empty? and titulo.to_s.empty? and
          comentarios_biblio.to_s.empty? and cartelera_f.to_s.empty? and tipo_de_relato.to_s.empty? and tipo.to_s.empty? and
          fuente_imagen.to_s.empty? and lugar.to_s.empty? and anotaciones.to_s.empty? and sintesis.to_s.empty? and
          atributos_iconograficos.to_s.empty? and procedencia.to_s.empty? and fecha.to_s.empty?) and not(id_imagen.to_s.empty?)

        f_avatar = nil
        if id_imagen && false
          id_imagen = "%04d" % id_imagen.to_i
          if File.exist?(@ruta_imagenes2+id_imagen+ '.jpg')
            #p @ruta_imagenes2+id_imagen+ '.jpg'
            #Se comenta para que no cargue la imagen
            f_avatar = File.open(@ruta_imagenes2+id_imagen+ '.jpg')
          elsif File.exist?(@ruta_imagenes2+id_imagen+ '.JPG')
            #p @ruta_imagenes2+id_imagen+ '.JPG'
            #Se comenta para que no cargue la imagen
            f_avatar = File.open(@ruta_imagenes2+id_imagen+ '.JPG')
          else
            p "No se encontró imagen #{@ruta_imagenes2+id_imagen}"
          end
        else
          #p "campo imagen error:#{@ruta_imagenes2+id_imagen}"
        end

        #Donante;
        obj_donante = Donor.find_or_create_by(:name=>donante)


        #autor
        autor = Author.find_or_create_by(:name=>autor)

        #Escenario;
        scene = Scene.find_or_create_by(:name=>escenario)

        #Técnica;
        tecnica = nil
        if tipo
          tecnica = Type.find_by(:id=>tipo)
        end

        #Fuenteimagen;
        fuente = Source.find_by(:id=>fuente_imagen)

        #Cartela;
        cartela = PhylacteryBillboard.find_or_create_by(:name=>cartelera_f)

        #TipoRelato;
        tipo_relato = StoryType.find_or_create_by(:name=>tipo_de_relato)

        #atributos_iconograficos;
        atribut_icono = IconographicAttribute.find_or_create_by(:name=>atributos_iconograficos)

        # Lugar
        if procedencia
          lugar_obj = Place.find_or_create_by(:name=>procedencia)
        end

        cat0 = row['Categorías']
        cat0_obj = Category.find_by(:name=> cat0)
        cat1 = row['sub1']
        cat1_obj = Category.find_by(:name=> cat1)
        cat2 = row['sub2']
        cat2_obj = Category.find_by(:name=> cat2)
        cat3 = row['sub3']
        cat3_obj = Category.find_by(:name=> cat3)
        cat4 = row['sub4']
        cat4_obj = Category.find_by(:name=> cat4)

        #País y ciudad
        pais_actual = nil
        ciudad_actual = nil
        if lugar
          pais_ciudad = lugar.split(',')
          if pais_ciudad[0]
            pais_actual = Country.find_by(:name_spanish => pais_ciudad[0].strip)
            if !pais_actual
              #Se comenta
              #p "No se encontró el país #{pais_ciudad[0]}"
            end
            if pais_ciudad[1]
              ciudad_actual = City.find_or_create_by(:name => pais_ciudad[1].strip)
            end
          end
        end
        begin
          artwork = Artwork.create(
              #:passage_id=>
              :id => id_imagen,
              #Se comenta para que no cargue la imagen
              :avatar =>f_avatar,
              :author_id=>autor.id,
              :scene_id=>scene.id,
              :type=>tecnica,
              :source_id=>fuente.nil? ? nil : fuente.id,
              :donor_id=>obj_donante.id,
              :iconographic_attribute_id=>atribut_icono.id,
              :phylactery_billboard_id=>cartela.id,
              :story_type_id=>tipo_relato.id,
              :title=>titulo,
              :annotation=>anotaciones,
              :synthesis=>sintesis,
              :biographic_comment=>comentarios_biblio,
              :place_id=>lugar_obj.nil? ? nil : lugar_obj.id,
              :annotation_date=>fecha,
              :actual_country => pais_actual,
              :actual_city => ciudad_actual,
              :category_1_id => cat0_obj.nil? ? nil :cat0_obj.id,
              :category_2_id => cat1_obj.nil? ? nil :cat1_obj.id,
              :category_3_id => cat2_obj.nil? ? nil :cat2_obj.id,
              :category_4_id => cat3_obj.nil? ? nil :cat3_obj.id,
              :category_5_id => cat4_obj.nil? ? nil :cat4_obj.id
          )
          artwork.save!
        rescue
          p "No se agrego la obra con id: #{id_imagen}"
        end
      else
        #p "Imagen: " + id_imagen.to_s
        #p "Id obra: " + id_obras.to_s
        #p "escenario_____" + escenario.nil?.to_s
        #p "donante_____" + donante.nil?.to_s
        #p "id_imagen_____" + id_imagen.nil?.to_s
        #p "autor_____" + autor.nil?.to_s
        #p "titulo _____" + titulo.nil?.to_s
        #p "comentarios_biblio _____" + comentarios_biblio.nil?.to_s
        #p "cartelera_f _____" + cartelera_f.nil?.to_s
        #p "tipo_de_relato _____" + tipo_de_relato.nil?.to_s
        #p "tipo _____" + tipo.nil?.to_s
        #p "vafuente_imagencio _____" + fuente_imagen.nil?.to_s
        #p "lugar _____" + lugar.nil?.to_s
        #p "anotaciones _____" + anotaciones.nil?.to_s
        #p "sintesis _____" + sintesis.nil?.to_s
        #p "atributos_iconograficos ____" + atributos_iconograficos.nil?.to_s
        #p "procedencia _____" + procedencia.nil?.to_s
        #p "fecha _____" + fecha.nil?.to_s
        #p "                              "
        #p "                              "
        #p "                              "
      end
    end
  end


  desc "Cargue de descriptores a obras"
  task load_desc_obras: :environment do
    p "Importando descriptores obras segunda base..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'descriptores_obras.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      desc = row['nombredes']
      id_obra = row['ID Imagen']
      ob_obra = Artwork.find(id_obra)
      ob_desc = Description.find_by(:description=>desc)
      if ob_desc
        ob_obra.descriptions << ob_desc
        ob_obra.save!
      end
    end
  end

  desc "Carge de simbolos a obras"
  task load_simb_obras: :environment do
    p "Importando simbolos obras segunda base..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'simbolo_obra.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      simb = row['Simbolo'].capitalize
      id_obra = row['ID Imagen']
      ob_obra = Artwork.find(id_obra)
      ob_simb = ArtworkSymbol.find_by(:name=>simb)
      if ob_simb
        ob_obra.artwork_symbols << ob_simb
        ob_obra.save!
      end
    end
  end

  desc "Carge de personajes a obras"
  task load_personajes_obras: :environment do
    p "Importando personajes obras segunda base..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'personaje_obra.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      if row['Personajes_ID']
        personaId = row['Personajes_ID']
        id_obra = row['ID Imagen']
        ob_obra = Artwork.find(id_obra)
        persona_obj = Character.find(personaId)
        ob_obra.characters << persona_obj
        ob_obra.save!
      end
    end
  end

  desc "Cargue de ciudades y países a obras"
  task load_lugares_obras_DB2: :environment do
    p "Cargando ciudades y países a obras"
    file = File.join(Rails.root, 'app', 'assets', 'data', 'Consulta2.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|
      #País y ciudad
      pais_actual = nil
      ciudad_origen = nil
      pais_origen = nil
      place = nil
      if row['Lugar']
        pais_ciudad = row['Lugar'].split(',')
        if pais_ciudad[0]
          if (pais_ciudad[0].strip == ('EEUU'))
            pais_ciudad[0] = 'Estados Unidos'
          end
          pais_origen = Country.find_by(:name_spanish => pais_ciudad[0].strip)
          if !pais_origen
            p "No se encontró el país #{pais_ciudad[0]}"
          end
          if pais_ciudad[1]
            if (pais_ciudad[1].strip == ('EEUU'))
              pais_ciudad[1] = 'Estados Unidos'
            end
            if Country.find_by(:name_spanish => pais_ciudad[1].strip)
              pais_actual = Country.find_by(:name_spanish => pais_ciudad[1].strip)
            else
              ciudad_origen = City.find_or_create_by(:name => pais_ciudad[1].strip)
            end
          end
        end
      end
      if row['Procedencia']
        place = Place.find_or_create_by(:name=>row['ProcedenciaIm'])
      end
      if row['ID Imagen']
        obra = Artwork.find(row['ID Imagen'].to_i)
        if obra
          #obra.actual_city = ciudad_actual
          obra.origin_country = pais_origen
          obra.origin_city = ciudad_origen
          obra.actual_country = pais_actual

          obra.save
        end
      end
    end
  end

  desc "Drags data for the authors"
  task load_author_data: :environment do
    p "Importando información de autores..."
    file = File.join(Rails.root, 'app', 'assets', 'data', 'autores.csv')
    csv_file = File.join(Rails.root, 'app', 'assets', 'data', 'autores_apellido.csv')
    CSV.foreach(file, :headers => true, :col_sep => ';') do |row|

      auth = row['author'].strip
      act = row['activity']
      bio = row['bio']
      
      found = false
      CSV.foreach(csv_file, :headers => true, :col_sep => ';') do |auth_row|
        if auth_row['base'] == auth
          found = true
          author = Author.find_by(:name => auth_row['nombre'], :lastname => auth_row['apellido'])
          if author
            author.activity = act
            author.biography = bio
            author.save
            p "Autor #{author.name} #{author.lastname} actualizado"
          else
            print "No se encontró el autor '#{auth}' en la base de datos"
          end
        end
      end
      if !found
        print "No se encontró el autor '#{auth}' en la autores_apellido"
      end
    end
  end

  desc "Resets all table sequences"
  task reset_table_sequences: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

end
