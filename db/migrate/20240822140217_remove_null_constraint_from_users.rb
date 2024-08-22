class RemoveNullConstraintFromUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :name, true
    change_column_null :users, :user_type, true
  end
end
