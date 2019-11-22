class AddStarttimeEndtineToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :start_time, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :tasks, :end_time, :datetime
  end
end