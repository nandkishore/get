require 'rubygems'
require 'active_record'

config = YAML.load_file("db/config.yml")["test"]
ActiveRecord::Base.establish_connection(config)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each do |file| 
  require file
end

ENV['env'] = "test"

INSTANCE_ID = 'i-ecb78288'
REGION = 'us-east-1a'
INSTANCE_STATE = 'running'
INSTANCE_FLAVOR = 'm1.medium'
START_TIME = '2011-12-05 18:14:42'
STOP_TIME = '2012-06-14 07:04:17'
RUN_ID = 1
