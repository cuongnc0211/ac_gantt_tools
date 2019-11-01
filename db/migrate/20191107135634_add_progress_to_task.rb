class AddProgressToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :actual_progress, :integer, default: 0
  end
end
