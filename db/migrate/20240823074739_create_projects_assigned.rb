class CreateProjectsAssigned < ActiveRecord::Migration[7.2]
  def change
    create_table :projects_assigneds do |t|
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :projects_assigneds, :projects,  column: :project_id
    add_foreign_key :projects_assigneds, :users, column: :user_id

    add_index :projects_assigneds, :project_id
    add_index :projects_assigneds, :user_id

  end
end
