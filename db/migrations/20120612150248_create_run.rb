class CreateRun < ActiveRecord::Migration
  def self.up
    create_table :runs do |t|
      t.string :instance_id, :null => false
      t.datetime :start_time
      t.datetime :stop_time
      t.string  :region
      t.string  :instance_state
      t.string  :instance_flavor
      
      t.timestamps
    end
  end

  def self.down
    drop_table "runs"
  end
end
