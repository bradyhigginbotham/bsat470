class ChangeProposalColumnTypes < ActiveRecord::Migration
  def self.up
    change_table :proposals do |t|
      t.change :created_at, :date
      t.change :updated_at, :date
    end
  end

  def self.down
    change_table :proposals do |t|
      t.change :created_at, :datetime
      t.change :updated_at, :datetime
    end
  end
end
