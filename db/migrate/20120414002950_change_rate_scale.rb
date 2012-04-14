class ChangeRateScale < ActiveRecord::Migration
  def up
    change_column :labor_assignments, :rate, :decimal, :precision => 10, :scale => 2
    change_column :materials, :unit_cost, :decimal, :precision => 10, :scale => 2
    change_column :labor_assignments, :rate_type, :string, :null => true
  end

  def down
    change_column :labor_assignments, :rate, :decimal, :precision => 10, :scale => 0
    change_column :materials, :unit_cost, :decimal, :precision => 10, :scale => 0
    change_column :labor_assignments, :rate_type, :string, :null => false
  end
end
