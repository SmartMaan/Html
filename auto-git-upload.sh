#!/bin/bash

# QuickCash Auto Git Upload Script
# This script automatically commits and pushes changes to GitHub

echo "🚀 Starting Auto Git Upload..."

# Add all changes
git add .

# Check if there are any changes to commit
if git diff --staged --quiet; then
    echo "✅ No changes to commit - working tree clean"
else
    # Get current timestamp
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Create commit message
    COMMIT_MSG="🔄 Auto Upload - $TIMESTAMP

✅ CHANGES UPLOADED:
- QuickCash app updates
- User requested modifications
- Automatic backup to GitHub

📅 Timestamp: $TIMESTAMP
🤖 Auto-uploaded by system"

    # Commit changes
    echo "📝 Committing changes..."
    git commit -m "$COMMIT_MSG"
    
    # Push to GitHub
    echo "⬆️ Pushing to GitHub..."
    git push origin cursor/implement-kyc-and-loan-application-workflow-1407
    
    echo "✅ Successfully uploaded to GitHub!"
    echo "🔗 Repository: https://github.com/SmartMaan/Html"
fi

echo "🎉 Auto Git Upload Complete!"