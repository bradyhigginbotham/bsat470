class AddClientToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :client_id, :integer, :null => false
  end

  def self.down
    remove_column :invoices, :client_id
  end
end
