class ChangeTaskFields < ActiveRecord::Migration
  def self.up
   change_column :tasks, :sqft, :integer, :null => false
   change_column :tasks, :price_per_sqft, :decimal, :precision => 10, :scale => 2, :null => false
  end

  def self.down
   change_column :tasks, :sqft, :integer, :null => true
   change_column :tasks, :price_per_sqft, :decimal, :precision => 10, :scale => 0, :null => true
  end
end
