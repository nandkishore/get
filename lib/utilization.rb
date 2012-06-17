require 'rubygems'
require 'aws-sdk'
require 'aws/cloud_watch'
require 'aws/cloud_watch/ec2'
require "yaml" 
require 'active_record' 

class Utilization < ActiveRecord::Base
                                               ## Connects to the CloudWatch API to get 
  def self.add(instance_id)                    ## CPU and Network Utilization each hour 

    api_keys = YAML.load_file("db/api_keys.yml")
    ec2 = AWS::EC2.new(:access_key_id => api_keys["access_key_id"], 
                       :secret_access_key => api_keys["secret_access_key"])
    
    instance = ec2.instances[instance_id]
    cpu =  instance.metrics['CPUUtilization'].get :average, 60*60, (Time.now.utc - 60*60)..Time.now.utc
    network =  instance.metrics['NetworkOut'].get :average, 60*60, (Time.now.utc - 60*60)..Time.now.utc
    cpu_utilization = 0.0
    network_utilization = 0.0
    network.each {|n| network_utilization += n[:average]}
    cpu.each {|c| cpu_utilization += c[:average]}
    
    if (!cpu.blank?) || (!network.blank?)
      utilization_record = Utilization.new(:instance_id => instance_id, :cpu => cpu_utilization, :network => network_utilization, :from => Time.now.utc - 60*60, :to => Time.now.utc)
      utilization_record.save!
    end
  end
end
