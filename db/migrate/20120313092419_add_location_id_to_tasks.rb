class AddLocationIdToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :location_id, :integer, :null => false
  end

  def self.down
    remove_column :tasks, :location_id
  end
end
