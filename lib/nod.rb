require 'rubygems'
require 'nod/gem_savvy'
require 'nod/git_cloner'
require 'nod/license_hunch'
require 'nod/bundle_parser'
require 'fileutils'

class Nod
  
  def initialize()
    @basedir = './tmp/git_repos'
    @git_cloner = GitCloner.new('./tmp/filling-in')
    @gem_savvy = GemSavvy.new
  end
  
  def get_license_report_for_gem(name)
    # puts "processing gem #{name}"
    url = @gem_savvy.git_clone_url name
    report = {}
    
    if !url.nil?
      tmp_dir = "#{@basedir}/#{name}"
      successful_clone = @git_cloner.clone_url url, tmp_dir
      if successful_clone && File.exists?(tmp_dir)
        files_in_repo = Dir.entries(tmp_dir)
        licenses = files_in_repo.select { |file_name| file_name if file_name =~ /license/i }
        # puts "licenses is #{licenses}"
        if !licenses.nil? && licenses.size > 0
          license_type = LicenseHunch.determine_license_from_file licenses[0], File.expand_path(File.dirname(__FILE__) + "/../#{tmp_dir}")
          report = {:gem_name => name, :gem_home_page => @gem_savvy.gem_home(name), :gem_source_url => url, :gem_license => license_type}
        else
          # puts "no license found for #{@gem_savvy.info_for(name)}"
          readme = files_in_repo.select { |file_name| file_name if file_name =~ /readme/i }
          if !readme.nil? && readme.size > 0
            # puts "\n\ngoing readme route with #{readme}"
            license_type = LicenseHunch.determine_license_from_file readme[0], File.expand_path(File.dirname(__FILE__) + "/../#{tmp_dir}")
            # puts "got? #{license_type}"              
            report = {:gem_name => name, :gem_home_page => @gem_savvy.gem_home(name), :gem_source_url => url, :gem_license => license_type}
          end
        end
      else
        # TODO handle this
        puts "in else? file didn't exist? gem is #{name}"
      end #file exists
    else
      info = @gem_savvy.info_for(name)
      # puts "info for #{name} is #{info}"
      report = {:gem_name => name, :gem_home_page => info['homepage_uri'], :gem_source_url => info['source_code_uri'], :gem_license => 'Cannot determine'}
    end
    # puts "returning report for gem #{name} -> #{report}"
    return report
  end
  
  def get_licenses_for(gemfile_path)
    parser = BundleParser.new(gemfile_path)
    all_names = parser.gem_names
    report = []
    
    all_names.each { | name | report <<  get_license_report_for_gem(name) }
    return report
  end
  # parse gemfile
  # for each gem
  #  get source url
  #  if url is git hub
  #    clone
  #    find license file
  #    determine MIT, Apache, etc
  #  if not source URL
  #    check description
  #    if not in description
  #    get home page for rubyforge
  #      parse home page and look for license
  
  
  # return a report -- it is an [] full of {}s 
  # { :name => 'gem name', :url => 'url', :license => 'MIT|Apache|unknown' }
  
end