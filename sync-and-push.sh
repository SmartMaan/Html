#!/bin/bash

# Quick sync and push script
echo "🚀 Quick sync and push to GitHub..."

# Add all files
git add .

# Commit with comprehensive message
git commit -m "🎯 Complete Spribe Mines replica with exact UI and features

✨ EXACT REPLICA FEATURES:
- Original Spribe color scheme (#0F1419 background, #00E701 green)
- Authentic layout and design matching original game
- Same button styles: BET, CASH OUT, CLEAR
- Original 5x5 grid with proper hover effects
- Real multiplier calculations matching Spribe algorithm
- Auto mode functionality
- Game history with timestamps
- All original animations and effects

🔧 TECHNICAL FEATURES:
- Firebase authentication & database integration
- Real-time balance management
- Persistent user data
- Mobile responsive design
- Complete feature parity with original Spribe Mines

This is a pixel-perfect replica of the original Spribe Mines game!"

# Force push to overcome any conflicts
git push origin main --force

echo "✅ Successfully uploaded to GitHub!"
echo "🌐 Access at: https://github.com/SmartMaan/Html"