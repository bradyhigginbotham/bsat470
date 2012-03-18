class RemoveFaxFromClients < ActiveRecord::Migration
  def up
    remove_column :clients, :fax
  end

  def down
    add_column :clients, :fax, :string, :null => true
  end
end
