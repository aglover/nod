require 'rubygems'
require 'bundler'
require 'gems'
# see https://gist.github.com/1722530

class GemSavvy
  
  # def initialize(gemfile_path)
  #   @lockfile = Bundler::LockfileParser.new(Bundler.read_file(gemfile_path))
  # end
  # 
  # def names
  #   names = []
  #   @lockfile.specs.each do |s|
  #     names << s.name
  #   end
  #   names
  # end
  
  def info_for(gem_name)
    Gems.info gem_name
  end
  
  def gem_home(gem_name)
    info = info_for gem_name
    info['homepage_uri']
  end
  
  def gem_source_home(gem_name)
    info = info_for gem_name
    info['source_code_uri']
  end
  
  def git_clone_url(gem_name)
    http_url = gem_home gem_name
    if !http_url.nil? && http_url.include?('github.com')
        "#{http_url.gsub('http://', 'git://')}.git"
    else
      http_url = gem_source_home gem_name
      if !http_url.nil? && http_url.include?('github.com')
          "#{http_url.gsub('http://', 'git://')}.git"
      else
        nil
      end
    end
  end
  
end