class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title,  :null => false
      t.string :status
      t.integer :sqft
      t.decimal :price_per_sqft
      t.integer :est_hours
      t.date :date_completed
      
      t.timestamps
    end
  end
end
