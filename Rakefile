require 'rubygems' 
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'echoe'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the authlogic_drc plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the authlogic_drc plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AuthlogicDRC'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Echoe.new('authlogic_drc', '0.1.0') do |p|
  p.description     = "Authlogic Add-on for DRC"
  p.url             = "http://github.com/dwaynemac/authlogic_drc"
  p.author          = "Dwayne Macgowan"
  p.email           = "dwaynemac@gmail.com"
#  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = ['drc_client']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }