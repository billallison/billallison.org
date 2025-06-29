# Comments Feature Implementation

This branch implements Giscus comments for the Hugo site.

## What's Included

### 1. Giscus Partial Template
- **File**: `layouts/partials/giscus.html`
- **Purpose**: Renders the Giscus comments widget
- **Features**: 
  - Conditional loading (only when enabled)
  - Configurable via Hugo parameters
  - Dark theme to match console theme
  - Lazy loading for performance

### 2. Updated Post Template
- **File**: `layouts/posts/single.html`
- **Changes**: 
  - Removed Disqus comments
  - Added Giscus comments integration
  - Comments appear at bottom of posts

### 3. Configuration
- **File**: `hugo.toml`
- **Added**: Complete Giscus configuration section
- **Status**: Disabled by default (enable = false)

### 4. Documentation
- **File**: `docs/GISCUS_SETUP.md`
- **Content**: Step-by-step setup instructions

## Technical Details

### Template Structure
```html
{{ if .Site.Params.giscus.enable }}
  <div id="comments" class="comments-section">
    <h3>Comments</h3>
    {{ partial "giscus.html" . }}
  </div>
{{ end }}
```

### Configuration Parameters
- `enable`: Toggle comments on/off
- `repo`: GitHub repository
- `repoId`: Repository ID from Giscus
- `category`: Discussion category
- `categoryId`: Category ID from Giscus
- `theme`: "dark" to match console theme
- And more...

## Setup Required

To activate comments:

1. **Enable GitHub Discussions** on the repository
2. **Install Giscus app** for the repository  
3. **Configure at giscus.app** to get IDs
4. **Update hugo.toml** with the configuration values
5. **Set enable = true** in the config

## Benefits

- ✅ **GitHub-powered**: Uses GitHub Discussions
- ✅ **No external service**: Self-hosted via GitHub
- ✅ **Moderation**: Built-in GitHub moderation tools
- ✅ **Mobile responsive**: Works on all devices
- ✅ **Theme integration**: Matches site design
- ✅ **Performance**: Lazy loading
- ✅ **Privacy-friendly**: No tracking cookies

## Testing

With comments disabled, the site builds normally without any comments section. When enabled with proper configuration, comments will appear at the bottom of all post pages.

## Future Enhancements

- Custom styling for better console theme integration
- Comment count display in post listings
- Email notifications via GitHub
- Custom discussion categories for different post types
