require 'test/unit'
require 'nod'

class SingleGemNodTest < Test::Unit::TestCase
  
  def test_single_gem_report
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('active_directory')
    assert_not_nil report
    assert_equal 'git://github.com/ajrkerr/active_directory.git', report[0][:gem_source_url]
  end
  
  def test_single_gem_report_vegas
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('vegas')
    assert_not_nil report
    assert_equal 'MIT', report[0][:gem_license]
  end
  
  def test_single_gem_report_activemodel
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('activemodel')
    assert_not_nil report
    assert_equal 'MIT', report[0][:gem_license]
  end
  
  
end