class BodyGesture < ActiveRecord::Base

  validates_uniqueness_of :name, :message => "El gesto ya existe."

  has_attached_file :image,
                    :styles =>  {  :large => "500x500>",
                                   :medium => "300x300>",
                                   :small => "200x200",
                                   :bigthumb => "150x150",
                                   :thumb => "100x100>"
                    },
                    :default_url => ":style/missing.png",
                    :url => "/assets/imagenesGestos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/imagenesGestos/:id/:style/:basename.:extension"
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  has_and_belongs_to_many :artworks

end