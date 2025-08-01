#!/usr/bin/env ruby
# Test script to validate the speakers table structure

require 'nokogiri'

# Read the speakers.md file
speakers_content = File.read('speakers.md')

# Extract HTML content (everything after the front matter)
html_content = speakers_content.split('---')[2]

# Parse the HTML
doc = Nokogiri::HTML::DocumentFragment.parse(html_content)

# Find the main table
main_table = doc.css('table').first

puts "Testing speakers table structure..."

# Test 1: Check if main table exists
if main_table.nil?
  puts "❌ FAIL: Main table not found"
  exit 1
else
  puts "✅ PASS: Main table found"
end

# Test 2: Check if main table has exactly one row
main_rows = main_table.css('> tr')
if main_rows.length != 1
  puts "❌ FAIL: Main table should have exactly 1 row, found #{main_rows.length}"
  exit 1
else
  puts "✅ PASS: Main table has exactly 1 row"
end

# Test 3: Check if main row has exactly 2 columns
main_columns = main_rows.first.css('> td')
if main_columns.length != 2
  puts "❌ FAIL: Main row should have exactly 2 columns, found #{main_columns.length}"
  exit 1
else
  puts "✅ PASS: Main row has exactly 2 columns"
end

# Test 4: Check if each column has 50% width
main_columns.each_with_index do |column, index|
  style = column['style']
  if style.nil? || !style.include?('width: 50%')
    puts "❌ FAIL: Column #{index + 1} should have width: 50%"
    exit 1
  else
    puts "✅ PASS: Column #{index + 1} has width: 50%"
  end
end

# Test 5: Check if left column has 3 speakers
left_column = main_columns[0]
left_speakers = left_column.css('table')
if left_speakers.length != 3
  puts "❌ FAIL: Left column should have 3 speakers, found #{left_speakers.length}"
  exit 1
else
  puts "✅ PASS: Left column has 3 speakers"
end

# Test 6: Check if right column has 3 speakers
right_column = main_columns[1]
right_speakers = right_column.css('table')
if right_speakers.length != 3
  puts "❌ FAIL: Right column should have 3 speakers, found #{right_speakers.length}"
  exit 1
else
  puts "✅ PASS: Right column has 3 speakers"
end

# Test 7: Check if all speakers have images
all_speakers = doc.css('table table')
if all_speakers.length != 6
  puts "❌ FAIL: Should have 6 speakers total, found #{all_speakers.length}"
  exit 1
else
  puts "✅ PASS: Found 6 speakers total"
end

# Test 8: Check if all speakers have images
images = doc.css('img')
if images.length != 6
  puts "❌ FAIL: Should have 6 speaker images, found #{images.length}"
  exit 1
else
  puts "✅ PASS: Found 6 speaker images"
end

# Test 9: Check specific speakers are in correct positions
expected_speakers = [
  'Graham Neubig',
  'Dawn Song', 
  'Michele Catasta',
  'Eiso Kant',
  'Sida I. Wang',
  'Junyang Lin'
]

actual_speakers = []
all_speakers.each do |speaker_table|
  strong_tags = speaker_table.css('strong')
  if strong_tags.length > 0
    actual_speakers << strong_tags.first.text.strip
  end
end

if actual_speakers != expected_speakers
  puts "❌ FAIL: Speaker order incorrect"
  puts "Expected: #{expected_speakers}"
  puts "Actual: #{actual_speakers}"
  exit 1
else
  puts "✅ PASS: All speakers found in correct order"
end

puts "\n🎉 All tests passed! The speakers table is correctly structured with two 50% width columns."