require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rdoc/task'

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'Your application title'
end

spec = eval(File.read('get.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/tc_*.rb']
end

task :default => :test
 begin
      require 'tasks/standalone_migrations'

      MigratorTasks.new do |t|
        # t.migrations = "db/migrations"
        # t.config = "db/config.yml"
        # t.schema = "db/schema.rb"
        # t.sub_namespace = "dbname"
        # t.env = "DB"
        # t.verbose = true
        # t.log_level = Logger::ERROR
      end
    rescue LoadError => e
      puts "gem install standalone_migrations to get db:migrate:* tasks! (Error: #{e})"
    end

begin
  gem 'delayed_job', '~>2.0.4'
  require 'delayed_job'
  require 'delayed/tasks'
  require 'activerecord'
  Dir[File.dirname(__FILE__) + '/lib/*.rb'].each do |file| 
  require file
  
end

  config = YAML.load_file("db/config.yml")["development"]
  ActiveRecord::Base.establish_connection(config)
  Delayed::Worker.backend = :active_record
end