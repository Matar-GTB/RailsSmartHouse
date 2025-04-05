class AddPointsToUtilisateurs < ActiveRecord::Migration[8.0]
  def change
    add_column :utilisateurs, :points, :integer
  end
end
