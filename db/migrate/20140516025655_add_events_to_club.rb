class AddEventsToClub < ActiveRecord::Migration
  def change
    add_column :clubs, :event_id, :integer
  end
end
