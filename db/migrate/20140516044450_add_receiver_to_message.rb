class AddReceiverToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :receiver, :user
  end
end
