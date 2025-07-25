#!/bin/bash

# QuickCash Auto-Save to GitHub Script
# This script automatically saves all code changes to GitHub

echo "🚀 QuickCash Auto-Save to GitHub Script"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}[GITHUB]${NC} $1"
}

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    print_error "Not in a git repository. Initializing..."
    git init
    git remote add origin https://github.com/SmartMaan/Html.git
    print_status "Git repository initialized"
fi

# Function to auto-commit and push changes
auto_save() {
    local commit_message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    print_header "Starting auto-save process..."
    
    # Check for changes
    if [ -z "$(git status --porcelain)" ]; then
        print_status "No changes to commit"
        return 0
    fi
    
    print_status "Changes detected, preparing to save..."
    
    # Add all changes
    git add .
    print_status "All files staged for commit"
    
    # Create commit message if not provided
    if [ -z "$commit_message" ]; then
        commit_message="Auto-save: QuickCash updates - $timestamp"
    fi
    
    # Commit changes
    git commit -m "$commit_message"
    print_status "Changes committed: $commit_message"
    
    # Push to current branch
    current_branch=$(git branch --show-current)
    print_status "Pushing to branch: $current_branch"
    
    git push origin "$current_branch"
    
    if [ $? -eq 0 ]; then
        print_status "✅ Successfully saved to GitHub!"
        print_status "🔗 Repository: https://github.com/SmartMaan/Html"
        print_status "📂 Branch: $current_branch"
        print_status "⏰ Timestamp: $timestamp"
    else
        print_error "❌ Failed to push to GitHub"
        return 1
    fi
}

# Function to create comprehensive commit with file analysis
smart_commit() {
    local files_changed=$(git diff --cached --name-only)
    local num_files=$(echo "$files_changed" | wc -l)
    
    if [ -z "$files_changed" ]; then
        git add .
        files_changed=$(git diff --cached --name-only)
        num_files=$(echo "$files_changed" | wc -l)
    fi
    
    # Analyze changes and create smart commit message
    local commit_msg="QuickCash Update: "
    
    if echo "$files_changed" | grep -q "quickcash.*\.html"; then
        commit_msg+="Enhanced HTML application with Firebase integration"
    elif echo "$files_changed" | grep -q "\.md$"; then
        commit_msg+="Updated documentation and README files"
    elif echo "$files_changed" | grep -q "\.js$"; then
        commit_msg+="JavaScript functionality improvements"
    elif echo "$files_changed" | grep -q "\.css$"; then
        commit_msg+="CSS styling and UI enhancements"
    elif echo "$files_changed" | grep -q "\.sh$"; then
        commit_msg+="Updated automation and deployment scripts"
    else
        commit_msg+="General application improvements and fixes"
    fi
    
    commit_msg+=" - $num_files file(s) modified"
    
    # Add detailed file list to commit
    local detailed_msg="$commit_msg

📂 Files modified:
$(echo "$files_changed" | sed 's/^/• /')

🕐 Auto-saved at: $(date '+%Y-%m-%d %H:%M:%S')"
    
    git commit -m "$detailed_msg"
    print_status "Smart commit created with analysis"
}

# Function to watch for file changes and auto-save
watch_and_save() {
    print_header "👁️  Starting file watcher for auto-save..."
    print_status "Monitoring QuickCash files for changes..."
    
    # Save immediately if there are pending changes
    if [ ! -z "$(git status --porcelain)" ]; then
        print_warning "Pending changes found, saving immediately..."
        smart_commit
        git push origin $(git branch --show-current)
    fi
    
    # Watch for file changes (if inotifywait is available)
    if command -v inotifywait >/dev/null 2>&1; then
        print_status "Using inotifywait for real-time monitoring..."
        while true; do
            inotifywait -r -e modify,create,delete,move . --exclude='\.git' 2>/dev/null
            sleep 5 # Wait 5 seconds to batch changes
            
            if [ ! -z "$(git status --porcelain)" ]; then
                print_status "🔄 Changes detected, auto-saving..."
                smart_commit
                git push origin $(git branch --show-current) && \
                print_status "✅ Auto-saved to GitHub successfully!" || \
                print_error "❌ Auto-save failed"
            fi
        done
    else
        # Fallback: periodic checking
        print_warning "inotifywait not available, using periodic checking..."
        while true; do
            sleep 30 # Check every 30 seconds
            
            if [ ! -z "$(git status --porcelain)" ]; then
                print_status "🔄 Changes detected, auto-saving..."
                smart_commit
                git push origin $(git branch --show-current) && \
                print_status "✅ Auto-saved to GitHub successfully!" || \
                print_error "❌ Auto-save failed"
            fi
        done
    fi
}

# Function to setup GitHub credentials
setup_github() {
    print_header "Setting up GitHub credentials..."
    
    # Check if already configured
    if git config user.name >/dev/null && git config user.email >/dev/null; then
        print_status "Git credentials already configured"
        print_status "Name: $(git config user.name)"
        print_status "Email: $(git config user.email)"
        return 0
    fi
    
    # Configure git if not already done
    read -p "Enter your GitHub username: " github_username
    read -p "Enter your GitHub email: " github_email
    
    git config user.name "$github_username"
    git config user.email "$github_email"
    
    print_status "GitHub credentials configured"
}

# Function to show current status
show_status() {
    print_header "📊 Current Repository Status"
    echo "Repository: https://github.com/SmartMaan/Html"
    echo "Current Branch: $(git branch --show-current)"
    echo "Last Commit: $(git log -1 --format='%h - %s (%cr)' 2>/dev/null || echo 'No commits yet')"
    echo ""
    
    local status_output=$(git status --porcelain)
    if [ -z "$status_output" ]; then
        print_status "✅ Working directory clean - all changes saved"
    else
        print_warning "📝 Uncommitted changes found:"
        git status --short
    fi
}

# Function to force save current state
force_save() {
    local custom_message="$1"
    print_header "💾 Force saving current state..."
    
    if [ -z "$custom_message" ]; then
        custom_message="QuickCash: Force save - $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    
    auto_save "$custom_message"
}

# Function to install dependencies
install_dependencies() {
    print_header "📦 Installing dependencies for auto-save..."
    
    # Check OS and install inotify-tools if available
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get >/dev/null; then
            sudo apt-get update && sudo apt-get install -y inotify-tools
        elif command -v yum >/dev/null; then
            sudo yum install -y inotify-tools
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew >/dev/null; then
            brew install fswatch
        fi
    fi
    
    print_status "Dependencies installation completed"
}

# Main menu
show_menu() {
    echo ""
    echo "🎯 QuickCash Auto-Save to GitHub"
    echo "================================="
    echo "1) 💾 Save Now (immediate save)"
    echo "2) 👁️  Watch & Auto-Save (continuous monitoring)"
    echo "3) 📊 Show Status"
    echo "4) ⚙️  Setup GitHub Credentials"
    echo "5) 📦 Install Dependencies"
    echo "6) 🔄 Force Save with Custom Message"
    echo "7) 🚪 Exit"
    echo ""
}

# Parse command line arguments
case "$1" in
    "now"|"save")
        force_save "$2"
        ;;
    "watch"|"monitor")
        watch_and_save
        ;;
    "status")
        show_status
        ;;
    "setup")
        setup_github
        ;;
    "install")
        install_dependencies
        ;;
    "help"|"--help"|"-h")
        echo "QuickCash Auto-Save to GitHub"
        echo "Usage: $0 [command] [message]"
        echo ""
        echo "Commands:"
        echo "  now, save           - Save immediately"
        echo "  watch, monitor      - Start continuous monitoring"
        echo "  status             - Show repository status"
        echo "  setup              - Setup GitHub credentials"
        echo "  install            - Install dependencies"
        echo "  help               - Show this help"
        echo ""
        echo "Examples:"
        echo "  $0 now                           # Save immediately"
        echo "  $0 save \"Custom commit message\"   # Save with custom message"
        echo "  $0 watch                         # Start monitoring"
        ;;
    "")
        # Interactive mode
        while true; do
            show_status
            show_menu
            read -p "Choose an option (1-7): " choice
            
            case $choice in
                1)
                    force_save
                    ;;
                2)
                    watch_and_save
                    ;;
                3)
                    show_status
                    ;;
                4)
                    setup_github
                    ;;
                5)
                    install_dependencies
                    ;;
                6)
                    read -p "Enter custom commit message: " custom_msg
                    force_save "$custom_msg"
                    ;;
                7)
                    print_status "👋 Goodbye! Your code is safely saved in GitHub"
                    exit 0
                    ;;
                *)
                    print_error "Invalid option. Please choose 1-7."
                    ;;
            esac
            
            echo ""
            read -p "Press Enter to continue..."
        done
        ;;
    *)
        print_error "Unknown command: $1"
        print_status "Run '$0 help' for usage information"
        exit 1
        ;;
esac