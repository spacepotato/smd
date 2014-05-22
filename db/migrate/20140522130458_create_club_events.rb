class CreateClubEvents < ActiveRecord::Migration
  def change
    create_table :club_events do |t|
      t.integer :club_id
      t.integer :event_id
      t.timestamps
    end
  end
end
