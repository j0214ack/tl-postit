class ChangeColumnNameOfRoles < ActiveRecord::Migration
  def change
    rename_column :roles, :user_id_id, :user_id
  end
end
