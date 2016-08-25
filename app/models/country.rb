class Country < ActiveRecord::Base
  has_many :artworks

  def self.filtros_place(author_id, author_lastname, category_id, country_id, nivel_id)
    query = 'SELECT DISTINCT "countries".* FROM "countries" RIGHT JOIN
    (SELECT A.* FROM "categories"
      RIGHT JOIN (SELECT "artworks".* FROM "artworks"
        LEFT JOIN authors ON authors.id = artworks.author_id
      %{author_query})A
      %{category_level_query}
    %{category_query})A2
    ON countries.id = A2.origin_country_id %{country_query}'

    author_query = ""
    category_query = ""
    country_query = ""
    category_level_query = ""

    author_lastname ? author_query = "WHERE authors.lastname LIKE '%#{author_lastname}%'" : nil
    author_id ? author_query = "WHERE authors.id = '#{author_id}'" : nil
    category_id ? category_query = "WHERE categories.id = #{category_id}" : nil
    country_id ? country_query = "WHERE countries.id = #{country_id}" : nil
    nivel_id ? category_level_query = "ON categories.id = A.category_#{nivel_id}_id" : category_level_query = "ON categories.id = A.category_1_id"

    find_by_sql (query % {author_query: author_query, category_query: category_query, country_query: country_query, category_level_query: category_level_query})
  end
end
