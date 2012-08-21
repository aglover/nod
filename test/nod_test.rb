require 'test/unit'
require 'nod'

class NodTest < Test::Unit::TestCase
  
  def test_green_light_report_for_one_gem
    gemfile_path = File.expand_path(File.dirname(__FILE__) + '/res/Gemfile.lock')
    green_light = Nod.new
    report = green_light.get_licenses_for gemfile_path
    report.each do |rep| 
      
      if rep[:gem_license].eql?('Unknown') || rep[:gem_license].eql?('Cannot determine')
        puts rep 
      end
      
      if rep[:gem_name].eql?('metaclass')
        assert_equal 'MIT', rep[:gem_license]
      end
    end
    assert_equal 57, report.size
    
  end
  
end