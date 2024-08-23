class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.integer :manager_id

      t.timestamps
    end

    add_foreign_key :projects, :users, column: :manager_id
    add_index :projects, :manager_id
    
  end
end
