class RemoveDefaultValueFromBugType < ActiveRecord::Migration[7.2]
  def change
    change_column_default :bugs, :bug_type, nil
  end
end
