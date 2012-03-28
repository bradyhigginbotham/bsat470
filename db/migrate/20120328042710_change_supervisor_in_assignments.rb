class ChangeSupervisorInAssignments < ActiveRecord::Migration
  def up
    remove_column :assignments, :supervisor
    add_column :assignments, :employee_id, :integer, :null => false
  end

  def down
    remove_column :assignments, :employee_id
    add_column :assignments, :supervisor, :string, :null => false
  end
end
