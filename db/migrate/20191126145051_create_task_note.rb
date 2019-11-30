class CreateTaskNote < ActiveRecord::Migration[5.2]
  def change
    create_table :task_notes do |t|
      t.integer :task_id
      t.text :content
      t.date :date

      t.timestamps
    end

    add_index :task_notes, :task_id
  end
end
