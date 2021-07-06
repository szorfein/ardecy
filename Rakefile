require 'rake/testtask'
require File.dirname(__FILE__) + '/lib/ardecy/version'

# run rake
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

# Usage: rake gem:build
namespace :gem do
  desc 'build the gem'
  task :build do
    Dir['ardecy*.gem'].each { |f| File.unlink(f) }
    system('gem build ardecy.gemspec')
    system("gem install ardecy-#{Ardecy::VERSION}.gem -P HighSecurity")
  end
end

task default: :test

