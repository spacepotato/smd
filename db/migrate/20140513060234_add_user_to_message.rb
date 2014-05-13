class AddUserToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :user, :recipient
  end
end
