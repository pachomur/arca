class AddAvatarColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_attachment :artworks, :avatar
    add_attachment :artworks, :sub_image
  end

  def self.down
    remove_attachment :artworks, :avatar
    remove_attachment :artworks, :sub_image
  end
end