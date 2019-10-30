class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    add_index :projects, :name
  end
end
