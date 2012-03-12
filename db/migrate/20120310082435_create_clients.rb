class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :number, :null => false
      t.string :name,   :null => false
      t.string :email,  :null => false
      t.string :phone
      t.string :fax
      t.string :billing_name
      t.string :billing_address, :null => false
      t.timestamps
    end
  end
end
