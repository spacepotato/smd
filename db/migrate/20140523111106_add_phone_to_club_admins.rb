class AddPhoneToClubAdmins < ActiveRecord::Migration
  def change
    add_column :club_admins, :phone, :string
  end
end
