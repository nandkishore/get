class CreatePerson < ActiveRecord::Migration
  def self.up
    create_table :Person do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age   
      t.timestamps
    end
  end
           
  def self.down
    drop_table :Person
  end
end
