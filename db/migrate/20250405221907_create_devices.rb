class CreateDevices < ActiveRecord::Migration[8.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :category
      t.string :location
      t.text :description
      t.float :value
      t.boolean :active

      t.timestamps
    end
  end
end
