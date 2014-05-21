class CreateClubAdmins < ActiveRecord::Migration
  def change
    create_table :club_admins do |t|
      t.column :club_id, :integer
      t.column :user_id, :integer

      t.timestamps
    end
  end
end