require 'test/unit'
require 'grit'
require 'fileutils'

class GritCloneRepoTest < Test::Unit::TestCase
  
  def test_cloning_repo_and_finding_lic
    tmp_dir = "#{@basedir}/work_queue"
    gritty = Grit::Git.new('./tmp/filling-in')
    gritty.clone({:quiet => false, :verbose => true, :progress => true}, 'git://github.com/fmmfonseca/work_queue.git', tmp_dir)
    files_in_repo = Dir.entries(tmp_dir)
    licenses = files_in_repo.select { |file_name| file_name if file_name =~ /license/i }
    assert_equal 1, licenses.size
    assert_equal 'LICENSE', licenses[0]
  end
  
  def test_cloning_repo_and_finding_lic_with_md
    tmp_dir = "#{@basedir}/gems"
    gritty = Grit::Git.new('./tmp/filling-in')
    gritty.clone({:quiet => false, :verbose => true, :progress => true}, 'git://github.com/rubygems/gems.git', tmp_dir)
    files_in_repo = Dir.entries(tmp_dir)
    licenses = files_in_repo.select { |file_name| file_name if file_name =~ /license/i }
    assert_equal 1, licenses.size
    assert_equal 'LICENSE.md', licenses[0]
  end
  
  def setup
    @basedir = './tmp/test/'
  end
  
  def teardown
    FileUtils.rm_rf @basedir
  end
  
end