class AddIsAnnouncementToComment < ActiveRecord::Migration
  def change
    add_column :comments, :is_announcement, :boolean
  end
end
