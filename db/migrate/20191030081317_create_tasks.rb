class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.integer :working_days
      t.references :member, foreign_key: true

      t.timestamps
    end

    add_index :tasks, :title
  end
end
