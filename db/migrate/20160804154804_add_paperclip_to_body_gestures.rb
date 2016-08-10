class AddPaperclipToBodyGestures < ActiveRecord::Migration
  def self.up
    add_attachment :body_gestures, :image
  end

  def self.down
    remove_attachment :body_gestures, :image
  end
end