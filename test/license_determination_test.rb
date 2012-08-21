require 'test/unit'

class LicenseDeterminationTest < Test::Unit::TestCase
  
  def test_read_info_description_to_find_lic
    info = "Diff::LCS is a port of Perl's Algorithm::Diff that uses the McIlroy-Hunt\nlongest common subsequence (LCS) algorithm to compute 
      intelligent differences\nbetween two sequenced enumerable containers. The implementation is based on\nMario I. Wolczko's {Smalltalk 
      version 1.2}[ftp://st.cs.uiuc.edu/pub/Smalltalk/MANCHESTER/manchester/4.0/diff.st]\n(1993) and Ned Konz's Perl version\n{Algorithm::Diff 
      1.15}[http://search.cpan.org/~nedkonz/Algorithm-Diff-1.15/].\n\nThis is release 1.1.3, fixing several small bugs found over the years. 
      Version\n1.1.0 added new features, including the ability to #patch and #unpatch changes\nas well as a new contextual diff callback, 
      Diff::LCS::ContextDiffCallbacks,\nthat should improve the context sensitivity of patching.\n\nThis library is called Diff::LCS because 
      of an early version of Algorithm::Diff\nwhich was restrictively licensed. This version has seen a minor license change:\ninstead of being
      under Ruby's license as an option, the third optional license\nis the MIT license."
    
    is_mit_lic = false
    is_mit_lic = true if info =~ /MIT License/i
    
    assert is_mit_lic 
  end
  
  def test_read_license_file_see_if_MIT
    file_path = File.expand_path(File.dirname(__FILE__) + '/res/LICENSE_1')
    is_mit_lic = false
    File.open(file_path, 'r').each_line do | line |
      is_mit_lic = true if line =~ /MIT License/i
    end
    assert is_mit_lic
  end
  
  def test_read_license_file_see_if_MIT_in_parans
    file_path = File.expand_path(File.dirname(__FILE__) + '/res/LICENSE_3')
    is_mit_lic = false
    File.open(file_path, 'r').each_line do | line |
      is_mit_lic = true if line =~ /MIT License/i
    end
    assert is_mit_lic
  end
  
  def test_read_license_file_see_if_apache
    file_path = File.expand_path(File.dirname(__FILE__) + '/res/APACHE')
    is_apache = false
    File.open(file_path, 'r').each_line do | line |
      is_apache = true if line =~ /Apache License/i
    end
    assert is_apache
  end
  
  def test_read_license_file_see_if_GPL
    file_path = File.expand_path(File.dirname(__FILE__) + '/res/GPL.lic')
    is_gpl = false
    File.open(file_path, 'r').each_line do | line |
      is_gpl = true if line =~ /GNU General Public License/i
    end
    assert is_gpl
  end
  
  def test_read_markdown_readme
    file_path = File.expand_path(File.dirname(__FILE__) + '/res/README.md')
    is_mit_lic = false
    File.open(file_path, 'r').each_line do | line |
      is_mit_lic = true if line =~ /MIT License/i
    end
    assert is_mit_lic
  end
  
  def test_looking_for_key_phrases
    phrase_1 = "to deal in the Software without restriction"
    phrase_2 = "Permission is hereby granted, free of charge, to any person obtaining"
    phrase_3 = "use, copy, modify, merge, publish"
    phrase_4 = "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY"
    phrase_5 = "distribute, sublicense"
    
    file_path = File.expand_path(File.dirname(__FILE__) + '/res/LICENSE.md')
    
    score = 0
    
    File.open(file_path, 'r').each_line do | line |
      score += 20 if (line =~ /#{phrase_1}/i || line =~ /#{phrase_2}/i || line =~ /#{phrase_3}/i || line =~ /#{phrase_4}/ || line =~ /#{phrase_5}/ ) 
    end
    
    assert_equal 100, score
  end
  
end