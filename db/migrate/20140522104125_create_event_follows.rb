class CreateEventFollows < ActiveRecord::Migration
  def change
    create_table :event_follows do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
