class CreateCosts < ActiveRecord::Migration
  def self.up
    create_table :costs do |t|
      t.string   :instance_id, :null => false
      t.float    :cost
      t.datetime :from
      t.datetime :to
      
      t.timestamps
    end
  end

  def self.down
    drop_table "costs"
  end
end
