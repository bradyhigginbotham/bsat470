class ProposalClientIdToNull < ActiveRecord::Migration
  def self.up
   change_column :proposals, :client_id, :integer, :null => true
  end

  def self.down
   change_column :proposals, :client_id, :integer, :null => false
  end
end
