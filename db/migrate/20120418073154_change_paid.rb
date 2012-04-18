class ChangePaid < ActiveRecord::Migration
  def up
    change_column :invoices, :paid, :boolean, :null => true
  end

  def down
    change_column :invoices, :paid, :boolean, :null => false
  end
end
