class AddParentClubToEvents < ActiveRecord::Migration
  def change
    add_column :events, :parent_club, :string
  end
end
