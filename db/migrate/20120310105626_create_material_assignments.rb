class CreateMaterialAssignments < ActiveRecord::Migration
  def change
    create_table(:material_assignments, :id => false) do |t|
      t.integer :task_id,       :null => false
      t.integer :material_id,   :null => false
      t.integer :assignment_id, :null => false
      t.integer :qty_sent,      :null => false
      t.integer :qty_used

      t.timestamps
    end
  end
end
