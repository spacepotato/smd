class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.date :event_date
      t.time :start_time

      t.timestamps
    end
  end
end
