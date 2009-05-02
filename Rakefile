require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

desc 'Default: run unit tests.'
task :default => :test

begin
  require 'jeweler'
  Jeweler::Tasks.new do |jewel|
    jewel.name = 'locale-routing'
    jewel.summary = 'LocaleRouting makes parsing I18N locale from an url parameters/hostname seamless.'
    jewel.email = 'tanel.suurhans@perfectline.ee'
    jewel.homepage = 'http://github.com/perfectline/locale-routing/tree/master'
    jewel.description = 'A library for configuring/parsin locales from url params or hostname for I18n.'
    jewel.authors = ["Tanel Suurhans", "Tarmo Lehtpuu"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc 'Test the LocaleRouting plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the LocaleRouting plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'LocaleRouting'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.markdown')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Generate code coverage report'
Rcov::RcovTask.new(:rcov) do |rcov|
  rcov.libs << 'test'
  rcov.test_files = FileList['test/*_test.rb']
  rcov.verbose = true
end
