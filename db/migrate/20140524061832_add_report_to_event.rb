class AddReportToEvent < ActiveRecord::Migration
  def change
    add_column :events, :report, :text
  end
end
