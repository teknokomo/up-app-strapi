#!/usr/bin/env bash
echo "=== Setting up Strapi 5.x ==="
echo "Checking Node.js and npm..."
node --version || exit 1
npm --version || exit 1

# Define paths
PROJECT_DIR="imp/strapi"

# Check if the project already exists
if [ -d "$PROJECT_DIR" ]; then
  echo "Project $PROJECT_DIR already exists. Updating dependencies..."
  cd "$PROJECT_DIR" || exit 1
  
  # Update dependencies
  npm install --loglevel=error
  
  # Build the admin panel
  echo "Building the admin panel..."
  npm run build --loglevel=error
  
  echo "=== Strapi setup completed! ==="
  exit 0
fi

# Create project directory
mkdir -p imp
cd imp || exit 1

echo "Initializing Strapi project in folder $PROJECT_DIR..."
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
npm install --loglevel=error

# Build the admin panel
echo "Building the admin panel..."
npm run build --loglevel=error

echo "=== Strapi setup completed! ==="