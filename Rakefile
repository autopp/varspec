# rubocop: disable Style/FileName

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

# Generate YARD Documentaion
YARD::Rake::YardocTask.new(:yard) do |t|
  t.files = ['lib/**/*.rb']
  t.options = %w(-m markdown)
end

file 'doc/frames.html' => FileList['lib/**/*.rb'] do |t|
  Rake::Task['yard'].invoke
end

task doc: 'doc/frames.html'

desc 'Open YARD Documentation in browser'
task :view, 'file'
task view: :doc do |t, a|
  cmd = /windows|cygwin/i =~ ENV['OS'] ? 'start' : 'open'
  
  system "#{cmd} doc/frames.html"
end
