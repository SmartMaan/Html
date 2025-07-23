#!/bin/bash

# Wanderlust Travel Agency - Development Server Startup Script
echo "🌍 Starting Wanderlust Travel Agency Website..."
echo "=========================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    echo "Visit: https://nodejs.org/"
    exit 1
fi

# Check if http-server is available
if ! command -v npx &> /dev/null; then
    echo "❌ npx is not available. Please update Node.js."
    exit 1
fi

echo "✅ Node.js found: $(node --version)"
echo "✅ npm found: $(npm --version)"
echo ""

# Start the development server
echo "🚀 Starting development server on http://localhost:3000"
echo "📱 The website is fully responsive - try different screen sizes!"
echo "🔧 Press Ctrl+C to stop the server"
echo ""

npx http-server . -p 3000 -c-1 -o