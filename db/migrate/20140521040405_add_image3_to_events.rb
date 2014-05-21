class AddImage3ToEvents < ActiveRecord::Migration
    def self.up
  	add_attachment :events, :image3
  end

  def self.down
  	remove_attachement :events, :image3
  end
end
