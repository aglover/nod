require 'rubygems'
require 'bundler'

class BundleParser
  
  def initialize(gemfile_path)
    @lockfile = Bundler::LockfileParser.new(Bundler.read_file(gemfile_path))
  end
  
  def gem_names
    names = []
    @lockfile.specs.each do |s|
      names << s.name
    end
    names
  end
  
end