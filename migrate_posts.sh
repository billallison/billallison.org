#!/bin/bash

# Migration script to move posts to date-based structure
# Usage: ./migrate_posts.sh

set -e

echo "Starting post migration to date-based structure..."

# Find all posts (excluding _index.md files)
find content/posts -name "index.md" | grep -v "_index.md" | while read -r post_file; do
    echo "Processing: $post_file"
    
    # Extract the directory name (post slug)
    post_dir=$(dirname "$post_file")
    post_slug=$(basename "$post_dir")
    
    # Skip if already in date structure
    if [[ "$post_dir" =~ content/posts/[0-9]{4}/[0-9]{2}/ ]]; then
        echo "  Already in date structure, skipping"
        continue
    fi
    
    # Extract date from front matter
    date_line=$(grep -m 1 "^date = " "$post_file" || echo "")
    if [[ -z "$date_line" ]]; then
        echo "  Warning: No date found in $post_file, skipping"
        continue
    fi
    
    # Parse date (format: date = '2025-06-28T10:50:00-07:00')
    date_value=$(echo "$date_line" | sed "s/date = ['\"]//g" | sed "s/['\"].*//g")
    year=$(echo "$date_value" | cut -d'-' -f1)
    month=$(echo "$date_value" | cut -d'-' -f2)
    
    echo "  Date: $year-$month"
    
    # Create target directory
    target_dir="content/posts/$year/$month/$post_slug"
    mkdir -p "$target_dir"
    
    # Move the entire post directory
    echo "  Moving to: $target_dir"
    if [[ -d "$target_dir" && "$(ls -A "$target_dir")" ]]; then
        echo "  Warning: Target directory not empty, skipping"
        continue
    fi
    
    # Copy files (using rsync to handle any subdirectories/assets)
    rsync -av "$post_dir/" "$target_dir/"
    
    # Remove original directory
    rm -rf "$post_dir"
    
    echo "  ✓ Moved successfully"
done

echo "Migration complete!"
echo ""
echo "Next steps:"
echo "1. Update front matter to include taxonomies"
echo "2. Remove old _index.md archive files"
echo "3. Test the new structure"
