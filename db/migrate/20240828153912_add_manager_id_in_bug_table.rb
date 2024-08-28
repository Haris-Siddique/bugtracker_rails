class AddManagerIdInBugTable < ActiveRecord::Migration[7.2]
  def change
    add_column :bugs, :manager_id, :integer

   

    add_index :bugs, :manager_id

    add_foreign_key :bugs, :users, column: :manager_id
  end
end
