class AddSenderIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sender_id, :int
  end
end
