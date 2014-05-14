class AddUserIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :user_id, :int
  end
end
