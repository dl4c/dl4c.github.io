#!/usr/bin/env python3
import subprocess
import sys
import os

# Change to the workspace directory
os.chdir('/workspace')

# Run the validation script
try:
    result = subprocess.run([sys.executable, 'validate_speakers.py'], 
                          capture_output=True, text=True, timeout=30)
    
    print("STDOUT:")
    print(result.stdout)
    
    if result.stderr:
        print("STDERR:")
        print(result.stderr)
    
    print(f"Return code: {result.returncode}")
    
except subprocess.TimeoutExpired:
    print("Validation script timed out")
except Exception as e:
    print(f"Error running validation: {e}")