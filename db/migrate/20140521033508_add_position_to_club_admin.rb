class AddPositionToClubAdmin < ActiveRecord::Migration
  def change
    add_column :club_admins, :position, :string
  end
end
