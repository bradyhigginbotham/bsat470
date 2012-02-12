class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :assignment_num, :null => false
      t.date :finish_date
      t.integer :vehicle_id
      t.date :authorization_date
      t.integer :work_order_id, :null => false
      t.integer :employee_id, :null => false
      t.string :authorized_by

      t.timestamps
    end
  end
end
