class CreateLaborAssignments < ActiveRecord::Migration
  def up
    create_table :labor_assignments do |t|
      t.integer :task_id,       :null => false
      t.integer :employee_id,   :null => false
      t.integer :assignment_id, :null => false
      t.decimal :rate,          :null => false
      t.string  :rate_type,     :null => false
      t.integer :est_hours,     :null => false
      t.integer :used_hours

      t.timestamps
    end
  end

  def down
    drop_table :labor_assignments
  end
end
