class AddImagesToEvents < ActiveRecord::Migration
  def self.up
  	add_attachment :events, :image
  end

  def self.down
  	remove_attachement :events, :image
  end
end
