class Artwork < ActiveRecord::Base

  validates_presence_of :title, :message => "Tiene que ingresar un titulo"
  validates_presence_of :category_1, :message => "Tiene que ingresar una categoria"
  validates_presence_of :author, :message => "Tiene que ingresar un autor"
  validates_presence_of :place, :message => "Tiene que ingresar un lugar"


  has_attached_file :avatar,
                    :styles => {
                        :large => "500x500>",
                        :medium => "300x300>",
                        :small  => "200x200>",
                        :slider  => "900x300>",
                        :thumb => "100x100>" },
                    :default_url => ":style/missing.png"

  has_attached_file :sub_image,
                    :styles => {
                        :large => "500x500>",
                        :medium => "300x300>",
                        :small  => "200x200>",
                        :slider  => "900x300>",
                        :thumb => "100x100>" },
                    :default_url => ":style/missing.png"

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]
  validates_attachment_content_type :sub_image, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]


  belongs_to :passage
  belongs_to :author
  belongs_to :scene
  belongs_to :type
  belongs_to :source
  belongs_to :donor
  belongs_to :story_type
  belongs_to :school

  #Origin and actual cities
  belongs_to :origin_city, class_name: "City"
  belongs_to :actual_city, class_name: "City"

  #Origin and actual countries
  belongs_to :origin_country, class_name: "Country"
  belongs_to :actual_country, class_name: "Country"

  #Place where the artwork comme => Procedencia
  belongs_to :place

  #Different categories
  belongs_to :category_1, class_name: "Category"
  belongs_to :category_2, class_name: "Category"
  belongs_to :category_3, class_name: "Category"
  belongs_to :category_4, class_name: "Category"
  belongs_to :category_5, class_name: "Category"


  has_many :phylactery_billboards
  has_many :iconographic_attributes

  has_many :artwork_characters
  has_many :characters, :through => :artwork_characters


  has_and_belongs_to_many :artwork_symbols
  has_and_belongs_to_many :descriptions
  has_and_belongs_to_many :engravings
  has_and_belongs_to_many :body_gestures

  accepts_nested_attributes_for :artwork_symbols, allow_destroy: true
  accepts_nested_attributes_for :descriptions, :reject_if => lambda{ |a| a[:description].blank? }, allow_destroy: true
  accepts_nested_attributes_for :body_gestures, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :iconographic_attributes, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :artwork_symbols, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :engravings, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :donor, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :passage, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :phylactery_billboards, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :scene, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :scene, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :school, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :source, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :story_type, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :type, :reject_if => lambda{ |a| a[:name].blank? }, allow_destroy: true

  def self.b_title(search)
    if not search.to_s.empty?
      where( 'lower(title) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.filtros(author_id, author_lastname, category_id, country_id, nivel_id)
    query = 'SELECT A2.* FROM "countries" RIGHT JOIN
    (SELECT A.* FROM "categories"
    RIGHT JOIN (SELECT "artworks".* FROM "artworks"
                LEFT JOIN authors ON authors.id = artworks.author_id
                %{author_query}
                ORDER BY authors.lastname, authors.name)A
     %{category_level_query}
    %{category_query})A2
    ON countries.id = A2.origin_country_id %{country_query};'

    author_query = ""
    category_query = ""
    country_query = ""
    category_level_query = ""

    author_lastname ? author_query = "WHERE authors.lastname LIKE '#{author_lastname}%'" : nil
    author_id ? author_query = "WHERE authors.id = '#{author_id}'" : nil
    category_id ? category_query = "WHERE categories.id = #{category_id}" : nil
    country_id ? country_query = "WHERE countries.id = #{country_id}" : nil
    nivel_id ? category_level_query = "ON categories.id = A.category_#{nivel_id}_id" : category_level_query = "ON categories.id = A.category_1_id"

    find_by_sql (query % {author_query: author_query, category_query: category_query, country_query: country_query, category_level_query: category_level_query})
  end

  def self.s_descriptions(search)
    if not search.to_s.empty?
      from('"artworks" INNER JOIN
      (
        SELECT DISTINCT A.ar_id FROM
        (SELECT  "artworks".id AS ar_id ,"artworks_descriptions".* FROM "artworks" LEFT JOIN artworks_descriptions ON artworks_descriptions.artwork_id = artworks.id)A
        LEFT JOIN
        descriptions ON A.description_id = descriptions.id

        WHERE ( lower(descriptions.description) LIKE ' "'%#{search.mb_chars.downcase}%'" ')
      ) B ON artworks.id = B.ar_id')
    else
      all
    end
  end

  def self.b_synthesis(search)
    if not search.to_s.empty?
      where( 'lower(synthesis) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_annotation(search)
    if not search.to_s.empty?
      where( 'lower(annotation) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_biographic_comment(search)
    if not search.to_s.empty?
      where( 'lower(biographic_comment) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_biographic_data(search)
    if not search.to_s.empty?
      where( 'lower(biographic_data) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_id(search)
    if search =~ /\A\d+\z/? true : false
      where( 'id = ?', "#{search.mb_chars.downcase}")
    else
      nil
    end
  end

  def self.b_country(search)
    if not search.to_s.empty?
      joins('LEFT JOIN countries ON countries.id = artworks.origin_country_id').where( 'lower(countries.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_countryactual(search)
    if not search.to_s.empty?
      joins('LEFT JOIN countries ON countries.id = artworks.actual_country_id').where( 'lower(countries.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_city(search)
    if not search.to_s.empty?
      joins('LEFT JOIN cities ON cities.id = artworks.origin_city_id').where( 'lower(cities.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_cityactual(search)
    if not search.to_s.empty?
      joins('LEFT JOIN cities ON cities.id = artworks.actual_city_id').where( 'lower(cities.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end


  def self.b_category_1(search)
    if not search.to_s.empty?
      joins('LEFT JOIN categories ON category_1_id = categories.id').where( 'lower(categories.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_category_2(search)
    if not search.to_s.empty?
      joins('LEFT JOIN categories ON category_2_id = categories.id').where( 'lower(categories.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_category_3(search)
    if not search.to_s.empty?
      joins('LEFT JOIN categories ON category_3_id = categories.id').where( 'lower(categories.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_category_4(search)
    if not search.to_s.empty?
      joins('LEFT JOIN categories ON category_4_id = categories.id').where( 'lower(categories.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end
  def self.b_category_5(search)
    if not search.to_s.empty?
      joins('LEFT JOIN categories ON category_5_id = categories.id').where( 'lower(categories.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_comment(search)
    if not search.to_s.empty?
      where( 'lower(comment) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_donor(search)
    if not search.to_s.empty?
      joins('LEFT JOIN donors ON donor_id = donors.id').where( 'lower(donors.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_phylactery_billboards(search)
    if not search.to_s.empty?
      joins('LEFT JOIN phylactery_billboards ON phylactery_billboard_id = phylactery_billboards.id').where( 'lower(phylactery_billboards.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_places(search)
    if not search.to_s.empty?
      joins('LEFT JOIN places ON place_id = places.id').where( 'lower(places.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_schools(search)
    if not search.to_s.empty?
      joins('LEFT JOIN schools ON school_id = schools.id').where( 'lower(schools.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_passages(search)
    if not search.to_s.empty?
      joins('LEFT JOIN passages ON passage_id = passages.id').where( 'lower(passages.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_iconographic_attributes(search)
    if not search.to_s.empty?
      joins('LEFT JOIN iconographic_attributes ON iconographic_attribute_id = iconographic_attributes.id').where( 'lower(iconographic_attributes.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_sources(search)
    if not search.to_s.empty?
      joins('LEFT JOIN sources ON source_id = sources.id').where( 'lower(sources.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_symbol (search)
    if not search.to_s.empty?
      joins('LEFT JOIN artwork_symbols_artworks ON artworks.id = artwork_symbols_artworks.artwork_id LEFT JOIN artwork_symbols ON artwork_symbols_artworks.artwork_symbol_id = artwork_symbols.id').where( 'lower(artwork_symbols.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_engravings (search)
    if not search.to_s.empty?
      joins('LEFT JOIN artworks_engravings ON artworks.id = artworks_engravings.artwork_id LEFT JOIN engravings ON artworks_engravings.engraving_id = engravings.id').where( 'lower(engravings.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_artwork_characters (search)
    if not search.to_s.empty?
      joins('LEFT JOIN artwork_characters ON artworks.id = artwork_characters.artwork_id LEFT JOIN characters ON artwork_characters.character_id = characters.id').where( 'lower(characters.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_artworks_body_gestures (search)
    if not search.to_s.empty?
      joins('LEFT JOIN artworks_body_gestures ON artworks.id = artworks_body_gestures.artwork_id LEFT JOIN body_gestures ON artworks_body_gestures.body_gesture_id = body_gestures.id').where( 'lower(body_gestures.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.b_annotationdate(search)
    if not search.to_s.empty?
      where( 'lower(annotation_date) LIKE ?', "%#{search.mb_chars.downcase.gsub(/\s+/, '')}%")
    else
      nil
    end
  end

  def self.b_scene(search)
    if not search.to_s.empty?
      joins('LEFT JOIN scenes ON scenes.id = artworks.scene_id').where( 'lower(scenes.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_story_types(search)
    if not search.to_s.empty?
      joins('LEFT JOIN story_types ON story_types.id = artworks.story_type_id').where( 'lower(story_types.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_types(search)
    if not search.to_s.empty?
      joins('LEFT JOIN types ON types.id = artworks.type_id').where( 'lower(types.name) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.b_author(search)
    if not search.to_s.empty?
      joins('LEFT JOIN authors ON authors.id = artworks.author_id').where( 'lower(authors.name) LIKE ?', "%#{search.mb_chars.downcase}%")
      joins('LEFT JOIN authors ON authors.id = artworks.author_id').where( 'lower(authors.lastname) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      nil
    end
  end

  def self.search_author(search)
    if search
      joins('LEFT JOIN authors ON authors.id = artworks.author_id').where( 'lower(authors.lastname) LIKE ?', "%#{search.mb_chars.downcase}%")
    else
      all
    end
  end

  def self.search_category(search)
    if search
      where('category_1_id = ?', search)
    else
      all
    end
  end

  def self.search_country(search)
    if search
      where('origin_country_id = ?', search)
    else
      all
    end
  end

  def get_title
    title ? title : "N/A"
  end

  def get_author_lastname
    author && author.lastname ? author.lastname : "N/A"
  end

  def get_activity
    activity ? activity : "N/A"
  end

  def get_creation_date
    creation_date ? creation_date : "N/A"
  end

  def get_annotation_date
    annotation_date ? annotation_date : "N/A"
  end

  def get_biographic_data
    biographic_data ? biographic_data : "N/A"
  end

  def get_signed
    signed ? "Si" : "No"
  end

  def get_category_1_name
    category_1 && category_1.name ? category_1.name : "N/A"
  end

  def get_category_2_name
    category_2 && category_2.name ? category_2.name : "N/A"
  end

  def get_category_3_name
    category_3 && category_3.name ? category_3.name : "N/A"
  end

  def get_category_4_name
    category_4 && category_4.name ? category_4.name : "N/A"
  end

  def get_category_5_name
    category_5 && category_5.name ? category_5.name : "N/A"
  end

  def get_annotation
    annotation ? annotation : "N/A"
  end

  def get_type_name
    type && type.name ? type.name : "N/A"
  end

  def get_source_name
    source && source.name ? source.name : "N/A"
  end

  def get_origin_country_name
    origin_country && origin_country.name ? origin_country.name : "N/A"
  end

  def get_actual_country_name
    actual_country && actual_country.name ? actual_country.name : "N/A"
  end

  def get_origin_city_name
    origin_city && origin_city.name ? origin_city.name : "N/A"
  end

  def get_actual_city_name
    actual_city && actual_city.name ? actual_city.name : "N/A"
  end

  def get_school_name
    school && school.name ? school.name : "N/A"
  end

  def get_synthesis
    synthesis ? synthesis : "N/A"
  end

  def get_biographic_comment
    biographic_comment ? biographic_comment : "N/A"
  end

  def get_scene_name
    scene && scene.name ? scene.name : "N/A"
  end

  def get_story_type_name
    story_type && story_type.name ? story_type.name : "N/A"
  end

  def get_donor_name
    donor && donor.name ? donor.name : "N/A"
  end

  def get_phylactery_billboard_name
    PhylacteryBillboard.find_by_id(phylactery_billboard_id) ? PhylacteryBillboard.find_by_id(phylactery_billboard_id).name : "N/A"
  end

  def get_iconographic_attribute_name
    IconographicAttribute.find_by(id:iconographic_attribute_id) ? IconographicAttribute.find_by(id:iconographic_attribute_id).name : "N/A"
  end

  def get_comment
    comment ? comment : "N/A"
  end

  def get_author_name
    author ? author.get_full_name : "N/A"
  end

  def get_author_biography
    author ? author.biography : "N/A"
  end

  def get_author_activity
    author ? author.activity : "N/A"
  end


  def get_place
    place ? place.name : "N/A"
  end

  def get_passage_history_type
    passage ? passage.get_history_type : "N/A"
  end

  def get_passage_name
    passage ? passage.name : "N/A"
  end

  def get_passage_source
    passage ? passage.source : "N/A"
  end

  def get_passage_text
    passage ? passage.text : "N/A"
  end

  def get_characters
    characters.order('name')
  end

end

