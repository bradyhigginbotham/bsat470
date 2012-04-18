class AddPaidToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :paid, :boolean, :null => false
  end

  def self.down
    remove_column :invoices, :paid
  end
end
