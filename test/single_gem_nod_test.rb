require 'test/unit'
require 'nod'

class SingleGemNodTest < Test::Unit::TestCase
  
  def test_single_gem_report
    # gemfile_path = File.expand_path(File.dirname(__FILE__) + '/res/Gemfile.lock')
    # parser = BundleParser.new(gemfile_path)

    nod = Nod.new(File.expand_path(File.dirname(__FILE__) + '/tmp/nod/all_gems'))
    report = []
    # parser.gem_names.each { |gem_name| report << nod.get_license_report_for_gem(gem_name) }
    report << nod.get_license_report_for_gem('active_directory')
    # report.each { |rep| puts rep }
    assert_not_nil report
    assert_equal 'git://github.com/ajrkerr/active_directory.git', report[0][:gem_source_url]
  end
  
end