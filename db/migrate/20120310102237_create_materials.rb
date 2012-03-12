class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name,       :null => false
      t.decimal :unit_cost, :null => false
      t.integer :quantity,  :null => false
      t.timestamps
    end
  end
end
