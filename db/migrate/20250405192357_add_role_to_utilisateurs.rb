class AddRoleToUtilisateurs < ActiveRecord::Migration[8.0]
  def change
    add_column :utilisateurs, :role, :string
  end
end
