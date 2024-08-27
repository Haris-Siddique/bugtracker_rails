class RenameColumnsInBugs < ActiveRecord::Migration[7.2]
  def change
    rename_column :bugs, :dedline, :deadline
    rename_column :bugs, :secreen_shot, :screen_shot
  end
end
