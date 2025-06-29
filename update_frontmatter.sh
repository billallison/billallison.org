#!/bin/bash

# Script to add year and month taxonomies to post front matter
# Usage: ./update_frontmatter.sh

set -e

echo "Adding taxonomies to post front matter..."

# Find all posts in the new structure
find content/posts -path "*/20*/*/index.md" | while read -r post_file; do
    echo "Processing: $post_file"
    
    # Extract year and month from path
    # Path format: content/posts/YYYY/MM/post-name/index.md
    path_parts=($(echo "$post_file" | tr '/' ' '))
    year=${path_parts[2]}
    month=${path_parts[3]}
    
    echo "  Adding taxonomies: year=$year, month=$month"
    
    # Check if taxonomies already exist
    if grep -q "^years = " "$post_file" || grep -q "^months = " "$post_file"; then
        echo "  Taxonomies already exist, skipping"
        continue
    fi
    
    # Create temporary file with updated front matter
    temp_file=$(mktemp)
    
    # Process the file
    in_frontmatter=false
    frontmatter_ended=false
    
    while IFS= read -r line; do
        if [[ "$line" == "+++" && "$in_frontmatter" == false ]]; then
            in_frontmatter=true
            echo "$line" >> "$temp_file"
        elif [[ "$line" == "+++" && "$in_frontmatter" == true ]]; then
            # Add taxonomies before closing +++
            echo "years = [\"$year\"]" >> "$temp_file"
            echo "months = [\"$month\"]" >> "$temp_file"
            echo "$line" >> "$temp_file"
            frontmatter_ended=true
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$post_file"
    
    # Replace original file
    mv "$temp_file" "$post_file"
    
    echo "  ✓ Updated successfully"
done

echo "Front matter update complete!"
