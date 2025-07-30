#!/usr/bin/env ruby
# Test to validate the speakers page layout matches the organizers page structure

require 'nokogiri'

def test_speakers_page_layout
  # Read the speakers page content
  speakers_content = File.read('speakers.md')
  
  # Check if the page uses table layout
  unless speakers_content.include?('<table style="margin-left: auto; margin-right: auto; width: 90%;border-collapse: collapse;">')
    puts "FAIL: Speakers page does not use the correct table layout"
    return false
  end
  
  # Check if avatar.png is used as default image
  unless speakers_content.include?('/assets/img/speakers/avatar.png')
    puts "FAIL: Speakers page does not use avatar.png as default image"
    return false
  end
  
  # Check if neubig.jpg is used for Graham Neubig
  unless speakers_content.include?('/assets/img/speakers/neubig.jpg')
    puts "FAIL: Speakers page does not use neubig.jpg for Graham Neubig"
    return false
  end
  
  # Check if all speakers are present
  speakers = ['Graham Neubig', 'Dawn Song', 'Michele Catasta', 'Eiso Kant', 'Sida I. Wang']
  speakers.each do |speaker|
    unless speakers_content.include?(speaker)
      puts "FAIL: Speaker #{speaker} not found in the page"
      return false
    end
  end
  
  # Check if the layout uses the same structure as organizers
  organizers_content = File.read('organizers.md')
  speakers_table_style = speakers_content.match(/<table style="([^"]*)">/)[1]
  organizers_table_style = organizers_content.match(/<table style="([^"]*)">/)[1]
  
  unless speakers_table_style == organizers_table_style
    puts "FAIL: Speakers table style does not match organizers table style"
    return false
  end
  
  puts "PASS: All tests passed! Speakers page layout successfully updated."
  return true
end

# Run the test
if __FILE__ == $0
  test_speakers_page_layout
end