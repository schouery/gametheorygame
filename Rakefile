# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'
require 'tasks/facebooker'
require 'metric_fu'

namespace :metrics do
  TEST_PATHS_FOR_RCOV = ['spec/**/*_spec.rb']
  RCOV_OPTIONS =  { "--include-files" => "/spec/" }
end
