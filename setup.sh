#!/usr/bin/env bash

echo "=== Setting up Strapi 5.x ==="
echo "Проверяем Node.js и npm..."
node --version
npm --version

# Инициализируем проект Strapi в текущей папке (.)
# --no-run чтобы не запускать сервер автоматически
npx create-strapi-app@latest . --no-run --quickstart

echo "Строим админку..."
npx strapi build

echo "=== Strapi setup completed! ==="
