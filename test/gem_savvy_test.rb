require 'test/unit'
require 'nod/gem_savvy'
require 'nod/bundle_parser'

class GemSavvyTest < Test::Unit::TestCase
  
  def test_it_can_get_list_of_gems
    gemfile_path = File.expand_path(File.dirname(__FILE__) + '/res/Gemfile.lock')
    green_light = BundleParser.new(gemfile_path)
    names = green_light.gem_names
    assert_equal 57, names.size
  end
  
  def test_it_can_get_list_of_gems_smaller_lock_file
    gemfile_path = File.expand_path(File.dirname(__FILE__) + '/res/Gemfile.lock_2')
    bundle_parse = BundleParser.new(gemfile_path)
    names = bundle_parse.gem_names
    assert_equal 11, names.size
    
    green_light = GemSavvy.new
    count = 0
    names.each do |name|
      # puts "name is #{name} and about to call clone url"
      url = green_light.git_clone_url name
      count += 1 if !url.nil?
      # puts "url for #{name} is #{url}"
      if url.nil?
        # puts "info for name is #{green_light.info_for(name)}"
      end
      
    end
    
    assert_equal 8, count
    
  end
  
  def test_it_can_return_info_for_gem
    gemfile_path = File.expand_path(File.dirname(__FILE__) + '/res/Gemfile.lock')
    green_light = GemSavvy.new(gemfile_path)
    info = green_light.info_for "work_queue"
    assert_not_nil info
    assert_equal 'http://github.com/fmmfonseca/work_queue', info['homepage_uri']
  end
  
  def test_it_can_return_home_for_gemm
    gemfile_path = File.expand_path(File.dirname(__FILE__) + '/res/Gemfile.lock')
    green_light = GemSavvy.new(gemfile_path)
    home = green_light.gem_home "work_queue"
    assert_not_nil home
    assert_equal 'http://github.com/fmmfonseca/work_queue', home
  end
  
  def test_it_can_return_clone_url
    gemfile_path = File.expand_path(File.dirname(__FILE__) + '/res/Gemfile.lock')
    green_light = GemSavvy.new(gemfile_path)
    clone = green_light.git_clone_url "work_queue"
    assert_not_nil clone
    assert_equal 'git://github.com/fmmfonseca/work_queue.git', clone
  end
  
  def test_replace_http_with_git
    http = 'http://github.com/fmmfonseca/work_queue'
    git = "#{http.gsub('http://', 'git://')}.git"
    assert_equal 'git://github.com/fmmfonseca/work_queue.git', git     
  end
  
end