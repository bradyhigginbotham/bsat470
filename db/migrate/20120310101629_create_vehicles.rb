class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :make,   :null => false
      t.string :model,  :null => false
      t.string :year,   :null => false
      t.boolean :checked_out, :null => false, :default => false
      t.timestamps
    end
  end
end
