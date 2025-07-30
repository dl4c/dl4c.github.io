#!/usr/bin/env ruby
# Test script to validate the speakers page structure and image references

require 'fileutils'

def test_speakers_page_structure
  puts "Testing speakers page structure..."
  
  # Read the speakers.md file
  speakers_content = File.read('speakers.md')
  
  # Test 1: Check if the page uses table layout
  if speakers_content.include?('<table style="margin-left: auto; margin-right: auto; width: 90%;border-collapse: collapse;">')
    puts "✓ Speakers page uses correct table layout"
  else
    puts "✗ Speakers page missing table layout"
    return false
  end
  
  # Test 2: Check if all speakers are present in table format
  expected_speakers = [
    'Graham Neubig',
    'Dawn Song', 
    'Michele Catasta',
    'Eiso Kant',
    'Sida I. Wang'
  ]
  
  expected_speakers.each do |speaker|
    if speakers_content.include?(speaker)
      puts "✓ Speaker #{speaker} found in page"
    else
      puts "✗ Speaker #{speaker} missing from page"
      return false
    end
  end
  
  # Test 3: Check if images are properly referenced
  if speakers_content.include?('/assets/img/speakers/neubig.jpg')
    puts "✓ Graham Neubig has specific image reference"
  else
    puts "✗ Graham Neubig missing specific image reference"
    return false
  end
  
  # Test 4: Check if avatar.png is used as default for other speakers
  avatar_count = speakers_content.scan('/assets/img/speakers/avatar.png').length
  if avatar_count == 4  # 4 speakers should use avatar.png
    puts "✓ Correct number of speakers using avatar.png as default"
  else
    puts "✗ Incorrect number of speakers using avatar.png (expected 4, got #{avatar_count})"
    return false
  end
  
  # Test 5: Check if content is preserved (sample check for one speaker's description)
  if speakers_content.include?('Associate Professor at the Language Technologies Institute of Carnegie Mellon University')
    puts "✓ Speaker content preserved"
  else
    puts "✗ Speaker content not preserved"
    return false
  end
  
  puts "All speakers page tests passed!"
  return true
end

def test_image_files_exist
  puts "\nTesting image file existence..."
  
  # Test if avatar.png exists in speakers directory
  if File.exist?('assets/img/speakers/avatar.png')
    puts "✓ Default avatar.png exists in speakers directory"
  else
    puts "✗ Default avatar.png missing in speakers directory"
    return false
  end
  
  # Test if neubig.jpg exists (specific speaker image)
  if File.exist?('assets/img/speakers/neubig.jpg')
    puts "✓ Graham Neubig's specific image exists"
  else
    puts "✗ Graham Neubig's specific image missing"
    return false
  end
  
  puts "All image file tests passed!"
  return true
end

# Run tests
if __FILE__ == $0
  puts "Running speakers page validation tests...\n"
  
  structure_test = test_speakers_page_structure
  image_test = test_image_files_exist
  
  if structure_test && image_test
    puts "\n🎉 All tests passed! Speakers page successfully updated with organizers page layout."
    exit 0
  else
    puts "\n❌ Some tests failed. Please check the issues above."
    exit 1
  end
end