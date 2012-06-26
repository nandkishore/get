class AddRunIdToCostsAndUtilizations < ActiveRecord::Migration
  def self.up
    add_column :costs, :run_id, :integer, :null => false
    add_column :utilizations, :run_id, :integer, :null => false
  end

  def self.down
    remove_column :costs, :run_id
    remove_column :utilizations, :run_id
  end
end
