require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
require 'sensor/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require 'dotenv'
Dotenv.load

Sensor::RakeTask.new(:sensor)
