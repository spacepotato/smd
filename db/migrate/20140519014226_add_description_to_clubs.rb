class AddDescriptionToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :description, :string
  end
end
