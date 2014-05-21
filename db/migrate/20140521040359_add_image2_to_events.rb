class AddImage2ToEvents < ActiveRecord::Migration
    def self.up
  	add_attachment :events, :image2
  end

  def self.down
  	remove_attachement :events, :image2
  end
end
