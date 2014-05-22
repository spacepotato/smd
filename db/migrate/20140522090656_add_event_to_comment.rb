class AddEventToComment < ActiveRecord::Migration
  def change
    add_column :comments, :event, :event
  end
end
