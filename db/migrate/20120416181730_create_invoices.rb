class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :number
      t.date :start_date,  :null => false
      t.date :end_date
      t.integer :employee_id, :null => false
      t.integer :work_order_id, :null => false

      t.timestamps
    end
  end
end
