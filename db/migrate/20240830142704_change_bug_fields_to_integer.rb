class ChangeBugFieldsToInteger < ActiveRecord::Migration[7.2]
  def change
    change_column :bugs, :bug_type, :integer, default: 0
    change_column :bugs, :status, :integer, default: 0
  end
end
