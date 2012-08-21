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
    if !http_url.nil? && http_url.include?('http://github.com') 
      get_sub_string(http_url, 'http://')
    elsif !http_url.nil? && http_url.include?('https://github.com')
      get_sub_string(http_url, 'https://')
    else
      http_url = gem_source_home gem_name
      if !http_url.nil? && http_url.include?('http://github.com')
        get_sub_string(http_url, 'http://')
      elsif !http_url.nil? && http_url.include?('http://www.github.com')
        get_sub_string(http_url, 'http://www.')
      else
        nil
      end
    end
  end
  
  def get_sub_string(http_url, to_replace)
    if http_url.end_with?('/')
      http_url = http_url[0..-2]
    end
    "#{http_url.gsub(to_replace, 'git://')}.git"
  end
  
end