class CreateWorkOrders < ActiveRecord::Migration
  def change
    create_table :work_orders do |t|
      t.text :notes
      t.date :date_required,  :null => false
      t.integer :employee_id, :null => false
      t.integer :proposal_id, :null => false

      t.timestamps
    end
  end
end
