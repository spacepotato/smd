class AddImageToClubs < ActiveRecord::Migration
   def self.up
  	add_attachment :clubs, :image
  end

  def self.down
  	remove_attachement :clubs, :image
  end
end
