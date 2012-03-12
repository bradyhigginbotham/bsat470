class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :number,         :null => false
      t.string :supervisor,     :null => false
      t.date :start_date,       :null => false
      t.date :end_date
      t.integer :vehicle_id
      t.integer :work_order_id, :null => false
      t.timestamps
    end
  end
end
