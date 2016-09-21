class Author < ActiveRecord::Base

  has_many :artworks
  nombre = :basename.rjust(9, '0')
  nombre = nombre.scan(/.{5}|.+/).join("/")
  has_attached_file :avatar,
                    :styles =>  {  :large => "500x500>",
                                  :medium => "300x300>",
                                  :thumb => "100x100>"
                                },
                    :default_url => ":style/missing.png",
                    :path => "/system/artworks/avatars/:basename/:style/:basename.:extension",
                    :url => "/system/artworks/avatars/"+ nombre + "/:style/:basename.:extension"
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  def get_full_name
    if !name && !lastname
      "N/A"
    elsif !name
      "#{lastname}"
    elsif !lastname
      "#{name}"
    else
      "#{lastname}, #{name}"
    end
  end
end
