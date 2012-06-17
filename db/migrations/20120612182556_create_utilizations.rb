class CreateUtilizations < ActiveRecord::Migration
  def self.up
    create_table :utilizations do |t|
      t.string   :instance_id, :null => false
      t.float    :cpu
      t.float    :network
      t.datetime :from
      t.datetime :to
      
      t.timestamps
    end
  end

  def self.down
    drop_table "utilizations"
  end
end
