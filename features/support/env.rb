require 'aruba/cucumber'

require 'rubygems'
require 'gli'
require 'aws-sdk'
require 'aws/cloud_watch'
require 'aws/cloud_watch/ec2'
require "yaml" 
require 'active_record' 
require 'tasks/standalone_migrations'
require 'delayed_job'
require 'date'
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
ENV['env'] = "test"
config = YAML.load_file("#{File.expand_path(File.dirname(__FILE__) + '/../../db/config.yml')}")[ENV['env']]
ActiveRecord::Base.establish_connection(config)
Before do
  @aruba_timeout_seconds = 300
end
