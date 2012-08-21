require 'rubygems'
require 'nod/gem_savvy'
require 'nod/git_cloner'
require 'nod/license_hunch'
require 'nod/bundle_parser'
require 'fileutils'
require 'open-uri'

class Nod
  
  def initialize(tmp_dir_to_write_to=nil)
    @basedir = tmp_dir_to_write_to || './tmp/git_repos'
    @git_cloner = GitCloner.new('./tmp/filling-in')
    @gem_savvy = GemSavvy.new
  end
  
  def get_license_report_for_gem(name)
    # puts "processing gem #{name}"
    url = @gem_savvy.git_clone_url name
    report = {}
    
    tmp_dir = "#{@basedir}/#{name}"
    if !url.nil?
      successful_clone = @git_cloner.clone_url url, tmp_dir
      if successful_clone && File.exists?(tmp_dir)
        files_in_repo = Dir.entries(tmp_dir)
        licenses_files = files_in_repo.select { |file_name| file_name if (file_name =~ /license/i || file_name =~ /readme/i || file_name =~ /copying/i)}
        # puts "license files for gem #{name} are #{licenses_files}, tmp dir is #{tmp_dir}"
        if !licenses_files.nil? && licenses_files.size > 0
          licenses_files.each do | file |
            license_type = LicenseHunch.determine_license_from_file file, tmp_dir
            unless license_type.nil?
              return get_report name, url, license_type
            end
          end
          report = get_report name, url, 'Unknown'
        else
          report = get_report name, url, 'Unknown'
        end
      else
        # TODO handle this
        info = @gem_savvy.info_for(name)
        puts "info is #{info}"
        puts "in else? file didn't exist? gem is #{name}"
      end #file exists
    else
      info = @gem_savvy.info_for(name)
      license_type = get_license_from_home_page info['homepage_uri'], tmp_dir
      report = {:gem_name => name, :gem_home_page => info['homepage_uri'], :gem_source_url => info['source_code_uri'], :gem_license => license_type }
    end
    return report
  end
  
  def get_license_from_home_page(web_page, tmp_dir)
    
    if web_page.nil?
      return nil
    end
    
    unless web_page.start_with?('http://')
      web_page = "http://#{web_page}"
    end
    
    license_type = 'Cannot determine'
    unless web_page.nil?
      unless Dir.exists?(tmp_dir)
        Dir.mkdir tmp_dir
      end
      File.open("#{tmp_dir}/webpage_source", 'w') do |file|
        file << open(web_page).read
      end
      license_type = LicenseHunch.determine_license_from_file 'webpage_source', tmp_dir
    end
    license_type
  end
  
  def get_report(gem_name, url, license_type)
    {:gem_name => gem_name, :gem_home_page => @gem_savvy.gem_home(gem_name), :gem_source_url => url, :gem_license => license_type}
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