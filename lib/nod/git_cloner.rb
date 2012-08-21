require 'rubygems'
require 'grit'

class GitCloner
  
  def initialize(tmp_dir)
    @tmp_dir = tmp_dir
    @gritty = Grit::Git.new(tmp_dir)
  end
  
  def clone_url(url, to_url)
    # puts "cloning #{url} to #{to_url}"
    begin
      @gritty.clone({:quiet => false, :verbose => true, :progress => true, :timeout => 320}, url, to_url)
      true
    rescue Exception => e 
      puts e.backtrace
      puts e.to_s
      puts "couldn't clone #{url}"
      false
    end
  end
  
end