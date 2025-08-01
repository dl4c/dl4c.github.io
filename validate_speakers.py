#!/usr/bin/env python3
"""
Validation script for speaker photos width implementation.
This script checks that the necessary CSS rules and HTML structure are in place.
"""

import os
import re
import sys

def check_file_exists(filepath):
    """Check if a file exists."""
    return os.path.exists(filepath)

def read_file_content(filepath):
    """Read and return file content."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception as e:
        print(f"Error reading {filepath}: {e}")
        return None

def validate_css_rules():
    """Validate that the CSS rules for speaker photos are present."""
    css_file = '/workspace/assets/css/custom.css'
    
    if not check_file_exists(css_file):
        return False, "custom.css file not found"
    
    content = read_file_content(css_file)
    if content is None:
        return False, "Could not read custom.css"
    
    # Check for speaker table CSS rules
    required_rules = [
        r'\.speakers-table\s+img\s*{',
        r'width:\s*200px\s*!important',
        r'min-width:\s*200px',
        r'max-width:\s*200px',
        r'@media\s*\(\s*max-width:\s*300px\s*\)',
        r'width:\s*180px\s*!important'
    ]
    
    missing_rules = []
    for rule in required_rules:
        if not re.search(rule, content, re.IGNORECASE):
            missing_rules.append(rule)
    
    if missing_rules:
        return False, f"Missing CSS rules: {missing_rules}"
    
    return True, "All CSS rules present"

def validate_html_structure():
    """Validate that the speakers.md file has the correct HTML structure."""
    speakers_file = '/workspace/speakers.md'
    
    if not check_file_exists(speakers_file):
        return False, "speakers.md file not found"
    
    content = read_file_content(speakers_file)
    if content is None:
        return False, "Could not read speakers.md"
    
    # Check for speakers-table class
    if 'class="speakers-table"' not in content:
        return False, "speakers-table class not found in table element"
    
    # Check that images still have width="200px" attribute
    img_pattern = r'<img[^>]*width="200px"[^>]*>'
    img_matches = re.findall(img_pattern, content, re.IGNORECASE)
    
    if not img_matches:
        return False, "No images with width='200px' found"
    
    # Count expected number of speaker images (should be 6 based on original file)
    if len(img_matches) < 5:  # Allow for some flexibility
        return False, f"Expected at least 5 speaker images, found {len(img_matches)}"
    
    return True, f"HTML structure valid with {len(img_matches)} speaker images"

def validate_test_file():
    """Validate that the test file was created."""
    test_file = '/workspace/test_speakers.html'
    
    if not check_file_exists(test_file):
        return False, "test_speakers.html file not found"
    
    content = read_file_content(test_file)
    if content is None:
        return False, "Could not read test_speakers.html"
    
    # Check for key test elements
    required_elements = [
        'class="speakers-table"',
        'Desktop View',
        'Mobile View',
        'Expected Results'
    ]
    
    missing_elements = []
    for element in required_elements:
        if element not in content:
            missing_elements.append(element)
    
    if missing_elements:
        return False, f"Missing test elements: {missing_elements}"
    
    return True, "Test file structure valid"

def main():
    """Run all validations."""
    print("Validating speaker photos width implementation...")
    print("=" * 50)
    
    tests = [
        ("CSS Rules", validate_css_rules),
        ("HTML Structure", validate_html_structure),
        ("Test File", validate_test_file)
    ]
    
    all_passed = True
    
    for test_name, test_func in tests:
        try:
            passed, message = test_func()
            status = "✓ PASS" if passed else "✗ FAIL"
            print(f"{test_name}: {status} - {message}")
            
            if not passed:
                all_passed = False
                
        except Exception as e:
            print(f"{test_name}: ✗ ERROR - {e}")
            all_passed = False
    
    print("=" * 50)
    if all_passed:
        print("✓ All validations passed!")
        print("\nNext steps:")
        print("1. Build the Jekyll site locally to test")
        print("2. Open test_speakers.html in a browser")
        print("3. Use browser dev tools to verify image dimensions")
        print("4. Test on different screen sizes/devices")
        return 0
    else:
        print("✗ Some validations failed!")
        print("Please review the errors above and fix the issues.")
        return 1

if __name__ == "__main__":
    sys.exit(main())