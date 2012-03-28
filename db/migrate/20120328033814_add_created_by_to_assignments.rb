class AddCreatedByToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :created_by, :integer, :null => false
  end

  def self.down
    remove_column :assignments, :created_by
  end
end
