require 'test/unit'
require 'nod'

class NodTest < Test::Unit::TestCase
  
  def test_green_light_report_for_one_gem
    gemfile_path = File.expand_path(File.dirname(__FILE__) + '/res/Gemfile.lock')
    green_light = Nod.new
    report = green_light.get_licenses_for gemfile_path
    report.each { |rep| puts rep }
    puts "report size is #{report.size}"

  end
  
end