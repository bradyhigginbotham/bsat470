class CreateLaborAssignments < ActiveRecord::Migration
  def change
    create_table :labor_assignments, :id => false do |t|
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
end
