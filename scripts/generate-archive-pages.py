#!/usr/bin/env python3
"""
Generate _index.md files for all year/month combinations that have posts
This ensures archive pages are automatically created for all existing content
"""

import os
import re
from pathlib import Path
from datetime import datetime

def main():
    # Get the content/posts directory
    posts_dir = Path(__file__).parent.parent / "content" / "posts"
    
    if not posts_dir.exists():
        print(f"Posts directory not found: {posts_dir}")
        return
    
    # Find all year/month combinations that have posts
    year_months = set()
    
    for year_dir in posts_dir.iterdir():
        if not year_dir.is_dir() or not year_dir.name.isdigit():
            continue
            
        year = year_dir.name
        
        for month_dir in year_dir.iterdir():
            if not month_dir.is_dir() or not month_dir.name.isdigit():
                continue
                
            month = month_dir.name
            
            # Check if this month directory has any posts (non-_index.md files)
            has_posts = False
            for item in month_dir.iterdir():
                if item.is_dir() and not item.name.startswith('.'):
                    # This is a post directory
                    has_posts = True
                    break
            
            if has_posts:
                year_months.add((year, month))
    
    print(f"Found {len(year_months)} year/month combinations with posts")
    
    # Generate _index.md files for each year/month combination
    month_names = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]
    
    for year, month in sorted(year_months):
        year_dir = posts_dir / year
        month_dir = year_dir / month
        
        # Create year _index.md if it doesn't exist
        year_index = year_dir / "_index.md"
        if not year_index.exists():
            year_content = f"""---
title: "Posts from {year}"
date: {year}-01-01
type: "posts-archive"
layout: "year-archive"
---
"""
            year_index.write_text(year_content)
            print(f"Created {year_index}")
        
        # Create month _index.md if it doesn't exist
        month_index = month_dir / "_index.md"
        if not month_index.exists():
            month_num = int(month)
            if 1 <= month_num <= 12:
                month_name = month_names[month_num - 1]
                month_content = f"""---
title: "Posts from {month_name} {year}"
date: {year}-{month:0>2}-01
type: "posts-archive"
layout: "month-archive"
---
"""
                month_index.write_text(month_content)
                print(f"Created {month_index}")

if __name__ == "__main__":
    main()
