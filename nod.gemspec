Gem::Specification.new do |s|
  s.name        = 'nod'
  s.version     = '0.0.4'
  s.date        = '2012-08-28'
  s.summary     = 'Green Light OSS baby'
  s.description = 'Gem reports on gemfile licenses'
  s.authors     = ['Andrew Glover']
  s.email       = 'ajglover@gmail.com'
  s.files       = ['lib/nod.rb', 'lib/nod/gem_savvy.rb', 'lib/nod/git_cloner.rb', 'lib/nod/license_hunch.rb', 'lib/nod/bundle_parser.rb']
  s.homepage    = 'https://github.com/aglover/nod'
  s.add_runtime_dependency 'bundler', ['~> 1.0.21']
  s.add_runtime_dependency 'gems', ['~> 0.7.0']
  s.add_runtime_dependency 'grit', ['~> 2.5.0']
  s.add_development_dependency 'rake', '~> 0.9.2'
  s.add_runtime_dependency 'nokogiri', '~> 1.5.5'
end