class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :number,         :null => false
      t.string :status,         :null => false
      t.date :decision_date
      t.string :est_method,     :null => false
      t.string :customer_type,  :null => false
      t.integer :client_id,     :null => false
      t.integer :employee_id,   :null => false
      t.timestamps
    end
  end
end
