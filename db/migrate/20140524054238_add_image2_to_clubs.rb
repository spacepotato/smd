class AddImage2ToClubs < ActiveRecord::Migration
     def self.up
  	add_attachment :clubs, :image2
  end

  def self.down
  	remove_attachement :clubs, :image2
  end
end
