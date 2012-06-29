require 'rubygems'
require "yaml" 

class Cost < ActiveRecord::Base
  belongs_to :run
  
  def self.compute_cost(instance_id, region, instance_flavor, run_id)      
                                    #Computes cost per hour refering to a yaml file for slabs 

    cost_table = YAML::load(File.open("#{File.expand_path(File.dirname(__FILE__) + '/../db/cost_table.yml')}"))  
    cost = cost_table[region][instance_flavor]
    cost_record = Cost.new(:instance_id => instance_id, :cost => cost, :from => Time.now.utc - 60*60, :to => Time.now.utc, :run_id => run_id)
    cost_record.save! 
  end
end
