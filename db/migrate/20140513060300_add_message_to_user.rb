class AddMessageToUser < ActiveRecord::Migration
  def change
    add_column :users, :message, :messages
  end
end
