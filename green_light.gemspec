Gem::Specification.new do |s|
  s.name        = 'green_light'
  s.version     = '0.0.1'
  s.date        = '2012-08-28'
  s.summary     = 'Green Light OSS baby'
  s.description = 'Gem reports on gemfile licenses'
  s.authors     = ['Andrew Glover']
  s.email       = 'ajglover@gmail.com'
  s.files       = ['lib/green_light.rb', 'lib/green_light/gem_savvy.rb']
  s.homepage    = 'https://github.com/aglover/green_light'
  s.add_runtime_dependency 'bundler', ['~> 1.0.21']
  s.add_runtime_dependency 'gems', ['~> 0.7.0']
  s.add_runtime_dependency 'grit', ['~> 2.5.0']
  s.add_development_dependency 'rake', '~> 0.9.2'
  s.add_runtime_dependency 'nokogiri', '~> 1.5.5'
end