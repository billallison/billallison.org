# Giscus Comments Setup Guide

This site uses [Giscus](https://giscus.app/) for comments, which is powered by GitHub Discussions.

## Setup Steps

### 1. Enable GitHub Discussions
1. Go to your repository on GitHub: `billallison/billallison.org`
2. Click on **Settings** tab
3. Scroll down to **Features** section
4. Check the box for **Discussions**

### 2. Install Giscus App
1. Visit https://github.com/apps/giscus
2. Click **Install**
3. Choose to install on your repository `billallison/billallison.org`

### 3. Configure Giscus
1. Go to https://giscus.app/
2. Enter your repository: `billallison/billallison.org`
3. Choose page ↔️ discussions mapping: **Discussion title contains page pathname**
4. Choose discussion category: **General** (or create a new one like "Comments")
5. Copy the generated configuration values

### 4. Update Hugo Configuration
Update the values in `hugo.toml`:

```toml
[params.giscus]
  enable = true  # Change to true to enable
  repo = "billallison/billallison.org"
  repoId = "R_your_repo_id_here"  # From giscus.app
  category = "General"
  categoryId = "DIC_your_category_id_here"  # From giscus.app
  # ... other settings remain the same
```

### 5. Test Comments
1. Build and deploy your site
2. Visit any post page
3. Comments section should appear at the bottom
4. Users need a GitHub account to comment

## Theme Customization

The comments are styled to match the console theme:
- Dark theme by default
- Positioned at the bottom of posts
- Lazy loading for better performance

## Features
- ✅ Markdown support in comments
- ✅ Emoji reactions
- ✅ GitHub login required (reduces spam)
- ✅ Moderation through GitHub Discussions
- ✅ Mobile responsive
- ✅ Dark/light theme support
