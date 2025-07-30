#!/bin/bash
# Simple validation script to check speakers page updates

echo "Validating speakers page updates..."

# Check if speakers.md contains table layout
if grep -q '<table style="margin-left: auto; margin-right: auto; width: 90%;border-collapse: collapse;">' speakers.md; then
    echo "✓ Speakers page uses correct table layout"
else
    echo "✗ Speakers page missing table layout"
    exit 1
fi

# Check if avatar.png is used as default
if grep -q '/assets/img/speakers/avatar.png' speakers.md; then
    echo "✓ Speakers page uses avatar.png as default image"
else
    echo "✗ Speakers page not using avatar.png as default"
    exit 1
fi

# Check if neubig.jpg is used for Graham Neubig
if grep -q '/assets/img/speakers/neubig.jpg' speakers.md; then
    echo "✓ Speakers page uses neubig.jpg for Graham Neubig"
else
    echo "✗ Speakers page not using neubig.jpg for Graham Neubig"
    exit 1
fi

# Check if all speakers are present
speakers=("Graham Neubig" "Dawn Song" "Michele Catasta" "Eiso Kant" "Sida I. Wang")
for speaker in "${speakers[@]}"; do
    if grep -q "$speaker" speakers.md; then
        echo "✓ Speaker '$speaker' found in page"
    else
        echo "✗ Speaker '$speaker' missing from page"
        exit 1
    fi
done

# Check if avatar.png file exists
if [ -f "assets/img/speakers/avatar.png" ]; then
    echo "✓ Default avatar.png file exists"
else
    echo "✗ Default avatar.png file missing"
    exit 1
fi

echo "All validations passed! Speakers page successfully updated."