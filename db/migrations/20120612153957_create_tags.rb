class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :run_id, :null => false
      t.string  :key
      t.string  :value
            
      t.timestamps
    end
  end

  def self.down
    drop_table "tags"
  end
end
