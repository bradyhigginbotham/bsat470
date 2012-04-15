class ChangeWorkOrderPrimary < ActiveRecord::Migration
  def self.up
    rename_column :work_orders, :primary, :level
  end

  def self.down
    rename_column :work_orders, :level, :primary
  end
end
