class AddImage3ToClubs < ActiveRecord::Migration
     def self.up
  	add_attachment :clubs, :image3
  end

  def self.down
  	remove_attachement :clubs, :image3
  end
end
