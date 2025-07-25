#!/bin/bash

# LoanHub Web Application Deployment Script
# This script helps deploy the loan application to various platforms

echo "🏦 LoanHub Deployment Script"
echo "=============================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Node.js and npm are installed"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

# Function to start local development server
start_dev_server() {
    echo "🚀 Starting development server..."
    echo "📍 Server will be available at: http://localhost:3000"
    echo "📄 Main application: http://localhost:3000/loan-app.html"
    echo ""
    echo "Press Ctrl+C to stop the server"
    npm run dev
}

# Function to deploy to Firebase
deploy_firebase() {
    echo "🔥 Deploying to Firebase..."
    
    if ! command -v firebase &> /dev/null; then
        echo "Installing Firebase CLI..."
        npm install -g firebase-tools
    fi
    
    echo "Please make sure you have:"
    echo "1. Created a Firebase project"
    echo "2. Enabled Firebase Hosting"
    echo "3. Logged in with 'firebase login'"
    echo ""
    read -p "Continue with Firebase deployment? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        firebase init hosting
        firebase deploy
        echo "✅ Deployed to Firebase successfully!"
    else
        echo "❌ Firebase deployment cancelled"
    fi
}

# Function to create static build
create_static_build() {
    echo "📦 Creating static build..."
    
    mkdir -p dist
    cp loan-app.html dist/index.html
    cp -r assets dist/ 2>/dev/null || true
    
    echo "✅ Static build created in ./dist directory"
    echo "📤 You can upload the ./dist directory to any static hosting service"
    echo "   - Netlify: Drag and drop the dist folder"
    echo "   - Vercel: Run 'vercel' in the dist directory"
    echo "   - GitHub Pages: Push dist contents to gh-pages branch"
}

# Function to run tests
run_tests() {
    echo "🧪 Running basic tests..."
    
    # Check if main HTML file exists
    if [ -f "loan-app.html" ]; then
        echo "✅ Main application file exists"
    else
        echo "❌ Main application file missing"
        exit 1
    fi
    
    # Check if package.json is valid
    if npm list --depth=0 &> /dev/null; then
        echo "✅ Package.json is valid"
    else
        echo "❌ Package.json has issues"
        exit 1
    fi
    
    # Start server and test if it responds
    echo "🌐 Testing server response..."
    npm start &
    SERVER_PID=$!
    sleep 3
    
    if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/loan-app.html | grep -q "200"; then
        echo "✅ Server responds correctly"
    else
        echo "❌ Server not responding"
    fi
    
    kill $SERVER_PID 2>/dev/null
    echo "✅ All tests passed!"
}

# Main menu
echo ""
echo "Choose deployment option:"
echo "1) Start development server"
echo "2) Deploy to Firebase"
echo "3) Create static build"
echo "4) Run tests"
echo "5) Exit"
echo ""

read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        start_dev_server
        ;;
    2)
        deploy_firebase
        ;;
    3)
        create_static_build
        ;;
    4)
        run_tests
        ;;
    5)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid option. Please choose 1-5."
        exit 1
        ;;
esac