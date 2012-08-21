require 'test/unit'
require 'nod'
require 'nod/gem_savvy'
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
  
  def test_single_gem_report_ffi
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('ffi')
    assert_not_nil report
    assert_equal 'MIT', report[0][:gem_license]
  end
  
  def test_single_gem_report_mongoid
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('mongoid')
    assert_not_nil report
    assert_equal 'MIT', report[0][:gem_license]
  end
  
  def test_single_gem_report_json
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('json')
    assert_not_nil report
    assert_equal 'Ruby License', report[0][:gem_license]
  end
  
  def test_single_gem_report_libxml_ruby
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('libxml-ruby')
    assert_not_nil report
    assert_equal 'MIT', report[0][:gem_license]
  end
  
  def test_single_gem_report_gems
 
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('gems')
    assert_not_nil report
    assert_equal 'MIT', report[0][:gem_license]
  end
  
  def test_single_gem_report_mongo
    savvy = GemSavvy.new
    
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('mongo')
    assert_not_nil report
    assert_equal 'Apache', report[0][:gem_license]
  end
  
  def test_single_gem_report_tilt
    savvy = GemSavvy.new
    
    puts "#{savvy.info_for('tilt')}"
    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    report << nod.get_license_report_for_gem('tilt')
    assert_not_nil report
    assert_equal 'MIT', report[0][:gem_license]
  end
end