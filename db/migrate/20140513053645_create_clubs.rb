class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :webLink
      t.integer :registrationNumber

      t.timestamps
    end
  end
end
