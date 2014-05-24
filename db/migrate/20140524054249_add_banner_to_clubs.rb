class AddBannerToClubs < ActiveRecord::Migration
  def self.up
  	add_attachment :clubs, :banner
  end

  def self.down
  	remove_attachement :clubs, :banner
  end
end
