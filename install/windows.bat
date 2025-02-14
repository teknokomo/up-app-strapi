@echo off
echo === Setting up Strapi 5.x ===
echo Checking Node.js and npm...

:: Check if Node.js is installed
node --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Node.js is not installed. Please install Node.js first.
    exit /b 1
)

:: Check if npm is installed
npm --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo npm is not installed. Please install npm first.
    exit /b 1
)

:: Define paths
set PROJECT_DIR=imp\strapi

:: Check if the project already exists
if exist "%PROJECT_DIR%" (
    echo Project %PROJECT_DIR% already exists. Updating dependencies...
    cd "%PROJECT_DIR%"
    
    :: Update dependencies
    call npm install --loglevel=error
    
    :: Build the admin panel
    echo Building the admin panel...
    call npm run build --loglevel=error
    
    echo === Strapi setup completed! ===
    exit /b 0
)

:: Create project directory
if not exist "imp" mkdir imp
cd imp

echo Initializing Strapi project in folder %PROJECT_DIR%...
echo Skip | npx create-strapi-app@latest strapi ^
  --quickstart ^
  --typescript ^
  --no-run ^
  --use-npm

:: Navigate to the project directory
cd strapi || exit /b 1

:: Check if the project was created successfully
if not exist "package.json" (
    echo Error: package.json not found. The project was not created.
    exit /b 1
)

:: Install dependencies
echo Installing dependencies...
call npm install --loglevel=error

:: Build the admin panel
echo Building the admin panel...
call npm run build --loglevel=error

echo === Strapi setup completed! ===    