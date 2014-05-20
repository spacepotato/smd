class AddTicketsToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :ticket_price, :integer
  	add_column :events, :num_of_tickets, :integer
  	add_column :events, :ticket_info, :string
  end
end
