class AddPrimaryAndLocationIdToWorkOrders < ActiveRecord::Migration
  def self.up
    add_column :work_orders, :primary,     :string,  :null => false
    add_column :work_orders, :location_id, :integer, :null => false
  end

  def self.down
    remove_column :work_orders, :primary
    remove_column :work_orders, :location_id
  end
end
