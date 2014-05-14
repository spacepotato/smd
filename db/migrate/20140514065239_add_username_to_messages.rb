class AddUsernameToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :username, :string, references: :users
  end
end
