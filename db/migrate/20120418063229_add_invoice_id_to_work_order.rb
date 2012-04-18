class AddInvoiceIdToWorkOrder < ActiveRecord::Migration
  def self.up
    add_column :work_orders, :invoice_id, :integer, :null => true
  end

  def self.down
    remove_column :work_orders, :invoice_id
  end
end
