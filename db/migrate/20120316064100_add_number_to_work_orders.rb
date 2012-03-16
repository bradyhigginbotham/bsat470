class AddNumberToWorkOrders < ActiveRecord::Migration
  def self.up
    add_column :work_orders, :number, :string, :null => false
  end

  def self.down
    remove_column :work_orders, :number
  end
end
