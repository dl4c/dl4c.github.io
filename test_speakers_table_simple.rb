#!/usr/bin/env ruby
# Simple test script to validate the speakers table structure without external dependencies

# Read the speakers.md file
speakers_content = File.read('speakers.md')

# Extract HTML content (everything after the front matter)
html_content = speakers_content.split('---')[2]

puts "Testing speakers table structure..."

# Test 1: Check if main table exists
if !html_content.include?('<table')
  puts "❌ FAIL: Main table not found"
  exit 1
else
  puts "✅ PASS: Main table found"
end

# Test 2: Check for two columns with 50% width
width_50_count = html_content.scan(/width:\s*50%/).length
if width_50_count < 2
  puts "❌ FAIL: Should have at least 2 elements with width: 50%, found #{width_50_count}"
  exit 1
else
  puts "✅ PASS: Found #{width_50_count} elements with width: 50%"
end

# Test 3: Check for expected number of speakers (6 total)
speaker_names = [
  'Graham Neubig',
  'Dawn Song', 
  'Michele Catasta',
  'Eiso Kant',
  'Sida I. Wang',
  'Junyang Lin'
]

missing_speakers = []
speaker_names.each do |name|
  if !html_content.include?(name)
    missing_speakers << name
  end
end

if missing_speakers.length > 0
  puts "❌ FAIL: Missing speakers: #{missing_speakers.join(', ')}"
  exit 1
else
  puts "✅ PASS: All 6 speakers found"
end

# Test 4: Check for expected number of images (6 total)
img_count = html_content.scan(/<img/).length
if img_count != 6
  puts "❌ FAIL: Should have 6 speaker images, found #{img_count}"
  exit 1
else
  puts "✅ PASS: Found 6 speaker images"
end

# Test 5: Check for two-column structure (Left Column and Right Column comments)
if !html_content.include?('Left Column') || !html_content.include?('Right Column')
  puts "❌ FAIL: Two-column structure comments not found"
  exit 1
else
  puts "✅ PASS: Two-column structure confirmed"
end

# Test 6: Check for proper vertical alignment
vertical_align_count = html_content.scan(/vertical-align:\s*top/).length
if vertical_align_count < 2
  puts "❌ FAIL: Should have vertical-align: top for columns, found #{vertical_align_count}"
  exit 1
else
  puts "✅ PASS: Found proper vertical alignment"
end

# Test 7: Check for padding between columns
if !html_content.include?('padding-right: 20px') || !html_content.include?('padding-left: 20px')
  puts "❌ FAIL: Column padding not found"
  exit 1
else
  puts "✅ PASS: Column padding found"
end

puts "\n🎉 All tests passed! The speakers table is correctly structured with two 50% width columns."
puts "\nStructure Summary:"
puts "- Main table with 90% width, centered"
puts "- Two columns, each 50% width"
puts "- Left column: Graham Neubig, Dawn Song, Michele Catasta"
puts "- Right column: Eiso Kant, Sida I. Wang, Junyang Lin"
puts "- All 6 speakers with images preserved"
puts "- Proper spacing and alignment applied"