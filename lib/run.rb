require 'rubygems'
require 'gli'
require 'aws-sdk'
require 'aws/cloud_watch'
require 'aws/cloud_watch/ec2'
require "yaml" 
require 'active_record' 
require 'rufus/scheduler'
require 'delayed_job'
require 'rspec'

class Run < ActiveRecord::Base
  has_many :tags
  
  def ==(other)
    return self.instance_id == other.instance_id && self.region == other.region && self.instance_state == other.instance_state && self.instance_flavor == other.instance_flavor
  end

  class << self
    def add(instance_id, region, instance_state, instance_flavor, start_time, stop_time=nil)
      begin
        return false if instance_id.blank? 
        run = Run.new(:instance_id => instance_id, :region => region, :instance_state => instance_state, :instance_flavor => instance_flavor, :start_time => start_time, :stop_time => stop_time)
        run_records = Run.find_all_by_instance_id(instance_id,:order => "created_at DESC")
        run_records.each{|r| @run_record = r if r.stop_time.nil?}
        
        if run_records.blank?
          if instance_state != "running"
            run.stop_time = Time.now.utc
          end
          run.save!
          Run.add_tags(run.id, run.instance_id)
        else
          if !@run_record.nil?
            if !(run == @run_record) || Run.check_for_change_in_tags(@run_record)
                                                     ## Check for Change in Attributes or Tags, 
                                                     ## and end Run record & start new run
              @run_record.update_attributes(:stop_time => Time.now.utc)
              run.save!
              Run.add_tags(run.id, run.instance_id)
            end 
            Cost.compute_cost(@run_record.instance_id, @run_record.region, @run_record.instance_flavor, @run_record.id)
            Utilization.add(@run_record.instance_id, @run_record.id)
          else 
            if !(run == run_records.first) || Run.check_for_change_in_tags(run_records.first)  
                                                     ## Check for Change in Attributes or Tags, 
                                                     ## and end Run record & start new run
              if instance_state != "running"
                run.stop_time = Time.now.utc
              end
              run.save!
              Run.add_tags(run.id, run.instance_id)
            end    
            Cost.compute_cost(run_records.first.instance_id, run_records.first.region, run_records.first.instance_flavor, run_records.first.id)
            Utilization.add(run_records.first.instance_id, run_records.first.id)
          end
          @run_record = nil
        end

        puts "=============== Run record saved successfully! ==============="
      rescue Exception => e  
        puts "======== Something went wrong while saving Run record! ========"
        puts e.message  
        #puts e.backtrace.inspect  
      end
    end

    def connect
      api_keys = YAML.load_file("#{File.expand_path(File.dirname(__FILE__) + '/../db/api_keys.yml')}")
      @ec2 = AWS::EC2.new(:access_key_id => api_keys["access_key_id"], 
                         :secret_access_key => api_keys["secret_access_key"])
      
      AWS.memoize do
        @ec2.instances.each do |i|
          Run.add(i.id, i.availability_zone, i.status.to_s, i.instance_type, i.launch_time)
        end
      end
                                  ## Runs every 60 Minutes
      Delayed::Job.enqueue(BackgroundJob.new(), 0, 60.minutes.from_now)
    end
    
    def add_tags(run_id, instance_id)
      instance = @ec2.instances[instance_id]
      instance.tags.each_pair do |tag_name,tag_value|
        Tag.add(run_id, tag_name, tag_value)
      end
    end
    
    def check_for_change_in_tags(run)
      api_keys = YAML.load_file("#{File.expand_path(File.dirname(__FILE__) + '/../db/api_keys.yml')}")
      ec2 = AWS::EC2.new(:access_key_id => api_keys["access_key_id"], 
                         :secret_access_key => api_keys["secret_access_key"])
      
      run_tags = Hash.new
      run.tags.each {|tag| run_tags[tag.key] = tag.value}
      
      new_tags = Hash.new
      instance = ec2.instances[run.instance_id]
      instance.tags.each_pair do |tag_name,tag_value|
        new_tags[tag_name] =  tag_value
      end
      
      if run_tags == new_tags
        return false
      else
        return true
      end
    end  
  end
end
