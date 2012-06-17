require 'rubygems'
require "yaml" 

class Cost < ActiveRecord::Base
  
  def self.compute_cost(instance_id, region, instance_flavor)      
                                    #Computes cost per hour refering to a yaml file for slabs 

    cost_table = YAML::load(File.open("db/cost_table.yml"))  
    cost = cost_table[region][instance_flavor]
    cost_record = Cost.new(:instance_id => instance_id, :cost => cost, :from => Time.now.utc - 60*60, :to => Time.now.utc)
    cost_record.save! 
  end
end
