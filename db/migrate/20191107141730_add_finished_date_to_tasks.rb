class AddFinishedDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :finished_date, :date
  end
end