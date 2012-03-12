class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address,      :null => false
      t.integer :client_id,   :null => false
      t.integer :proposal_id

      t.timestamps
    end
  end
end
