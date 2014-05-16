class AddSenderToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sender, :user
  end
end
