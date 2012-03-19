class AddCityStZipToClientsAndLocations < ActiveRecord::Migration
  def self.up
    add_column :clients, :city, :string, :null => false
    add_column :clients, :state, :string, :null => false, :limit => 2
    add_column :clients, :zip, :string, :null => false, :limit => 5

    add_column :locations, :city, :string, :null => false
    add_column :locations, :state, :string, :null => false, :limit => 2
    add_column :locations, :zip, :string, :null => false, :limit => 5
  end

  def self.down
    remove_column :clients, :city
    remove_column :clients, :state
    remove_column :clients, :zip

    remove_column :locations, :city
    remove_column :locations, :state
    remove_column :locations, :zip
  end
end
