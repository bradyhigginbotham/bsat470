class ChangeWorkOrderPrimary < ActiveRecord::Migration
  def self.up
    rename_column :work_orders, :type, :level
  end

  def self.down
    rename_column :work_orders, :level, :type
  end
end
