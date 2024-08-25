class CreateBugs < ActiveRecord::Migration[7.2]
  def change
    create_table :bugs do |t|
      t.string :title,         null: false
      t.text :description
      t.date :dedline
      t.string :secreen_shot
      t.string :type,          null: false
      t.string :status,        null: false
      t.integer :project_id
      t.integer :developer_id
      t.integer :qa_id

      t.timestamps
    end

    add_foreign_key :bugs, :projects, column: :project_id
    add_foreign_key :bugs, :users, column: :developer_id
    add_foreign_key :bugs, :users, column: :qa_id

    add_index :bugs, :project_id
    add_index :bugs, :developer_id
    add_index :bugs, :qa_id

  end
end
