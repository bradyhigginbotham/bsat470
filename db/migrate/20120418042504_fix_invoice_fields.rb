class FixInvoiceFields < ActiveRecord::Migration
  def up
    remove_column :invoices, :employee_id
    remove_column :invoices, :work_order_id

    change_column :invoices, :number, :string, :null => false
    change_column :invoices, :end_date, :date, :null => false
  end

  def down
    add_column :invoices, :employee_id, :integer
    add_column :invoices, :work_order_id, :integer

    change_column :invoices, :number, :string, :null => true
    change_column :invoices, :end_date, :date, :null => true
  end
end
