#!/bin/bash

echo "Validating speakers page changes..."
echo "=================================="

# Check if speakers.md contains table structure
if grep -q '<table style="margin-left: auto; margin-right: auto; width: 90%;border-collapse: collapse;">' speakers.md; then
    echo "✓ Speakers page uses correct table layout"
else
    echo "✗ Speakers page missing table layout"
    exit 1
fi

# Check if all speakers are present
speakers=("Graham Neubig" "Dawn Song" "Michele Catasta" "Eiso Kant" "Sida I. Wang")
for speaker in "${speakers[@]}"; do
    if grep -q "$speaker" speakers.md; then
        echo "✓ Speaker $speaker found in page"
    else
        echo "✗ Speaker $speaker missing from page"
        exit 1
    fi
done

# Check if neubig.jpg is referenced for Graham Neubig
if grep -q '/assets/img/speakers/neubig.jpg' speakers.md; then
    echo "✓ Graham Neubig has specific image reference"
else
    echo "✗ Graham Neubig missing specific image reference"
    exit 1
fi

# Check if avatar.png is used as default
avatar_count=$(grep -c '/assets/img/speakers/avatar.png' speakers.md)
if [ "$avatar_count" -eq 4 ]; then
    echo "✓ Correct number of speakers using avatar.png as default ($avatar_count)"
else
    echo "✗ Incorrect number of speakers using avatar.png (expected 4, got $avatar_count)"
    exit 1
fi

# Check if content is preserved
if grep -q 'Associate Professor at the Language Technologies Institute of Carnegie Mellon University' speakers.md; then
    echo "✓ Speaker content preserved"
else
    echo "✗ Speaker content not preserved"
    exit 1
fi

# Check if image files exist
if [ -f "assets/img/speakers/avatar.png" ]; then
    echo "✓ Default avatar.png exists in speakers directory"
else
    echo "✗ Default avatar.png missing in speakers directory"
    exit 1
fi

if [ -f "assets/img/speakers/neubig.jpg" ]; then
    echo "✓ Graham Neubig's specific image exists"
else
    echo "✗ Graham Neubig's specific image missing"
    exit 1
fi

echo ""
echo "🎉 All validation checks passed!"
echo "Speakers page successfully updated with organizers page layout."