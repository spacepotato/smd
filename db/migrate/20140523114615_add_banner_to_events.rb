class AddBannerToEvents < ActiveRecord::Migration
  def self.up
  	add_attachment :events, :banner
  end

  def self.down
  	remove_attachement :events, :banner
  end
end
