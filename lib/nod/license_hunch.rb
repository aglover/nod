require 'rubygems'

class LicenseHunch

  def self.determine_license_from_file(license_name, base_path)
    
    if license_name.downcase.include?('mit')
      return 'MIT'
    end
    
    file_path = "#{base_path}/#{license_name}"
    is_mit_lic = false
    File.open(file_path, 'r').each_line do | line |
      # puts "line is #{line}"
      return 'MIT' if (line =~ /MIT License/i || line =~ /MIT/i || line =~ /mit-license/i)
      return 'Ruby License' if (line =~ /Ruby license/i)
      return 'Apache' if (line =~ /Apache License/i)
    end

    all_text = File.open(file_path).read.gsub(/\n/,' ')

    phrase_1 = "to deal in the Software without restriction"
    phrase_2 = "Permission is hereby granted, free of charge, to any person obtaining"
    phrase_3 = "use, copy, modify, merge, publish"
    phrase_4 = "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY"
    phrase_5 = "distribute, sublicense"
    return 'MIT' if (all_text =~ /#{phrase_1}/i && all_text =~ /#{phrase_2}/i && all_text =~ /#{phrase_3}/i && all_text =~ /#{phrase_4}/ && all_text =~ /#{phrase_5}/ ) 

    return nil

  end
  
end