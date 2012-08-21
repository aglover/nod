require 'rake/testtask'

desc "runs all tests"
task :default => [:test]

desc "runs Test::Unit tests in the test/ directory"
Rake::TestTask.new(:test) do |tsk|
  tsk.test_files = FileList['test/*_test.rb']
end


