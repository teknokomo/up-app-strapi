#!/usr/bin/env bash
echo "=== Setting up Strapi 5.x ==="
# Check Node.js and npm versions
echo "Checking Node.js and npm..."
node --version || { echo "Node.js is not installed."; exit 1; }
npm --version || { echo "npm is not installed."; exit 1; }

# Define absolute paths
BASE_DIR="$(pwd)"
PROJECT_DIR="$BASE_DIR/imp/strapi"

# Check if the project already exists
if [ -d "$PROJECT_DIR" ]; then
  echo "Project $PROJECT_DIR already exists. Updating dependencies..."
  cd "$PROJECT_DIR" || exit 1
  
  # Update dependencies
  echo "Updating dependencies..."
  npm install || { echo "Failed to update dependencies."; exit 1; }
  
  # Build the admin panel
  echo "Building the admin panel..."
  npm run build || { echo "Failed to build the admin panel."; exit 1; }
  
  echo "=== Strapi setup completed! ==="
  exit 0
fi

# Create project directory
mkdir -p "$BASE_DIR/imp"
cd "$BASE_DIR/imp" || exit 1
echo "Initializing Strapi project in folder $PROJECT_DIR..."

# Create Strapi project
echo "Skip" | npx create-strapi-app@latest strapi \
  --quickstart \
  --typescript \
  --no-run \
  --use-npm

# Navigate to the project directory
cd strapi || exit 1

# Check if the project was created successfully
if [ ! -f "package.json" ]; then
  echo "Error: package.json not found. The project was not created."
  exit 1
fi

# Install dependencies
echo "Installing dependencies..."
npm install || { echo "Failed to install dependencies."; exit 1; }

# Build the admin panel
echo "Building the admin panel..."
npm run build || { echo "Failed to build the admin panel."; exit 1; }

echo "=== Strapi setup completed! ==="