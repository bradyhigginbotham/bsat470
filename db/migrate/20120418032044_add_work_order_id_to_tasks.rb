class AddWorkOrderIdToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :work_order_id, :integer, :null => true
  end

  def self.down
    remove_column :tasks, :work_order_id
  end
end
