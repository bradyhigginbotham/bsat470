class CreateMaterialAssignments < ActiveRecord::Migration
  def up
    create_table :material_assignments do |t|
      t.integer :task_id,       :null => false
      t.integer :material_id,   :null => false
      t.integer :assignment_id, :null => false
      t.integer :qty_sent,      :null => false
      t.integer :qty_used

      t.timestamps
    end
  end

  def down
    drop_table :material_assignments
  end
end
