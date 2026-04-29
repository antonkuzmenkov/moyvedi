#!/usr/bin/env bash
# Веди — deploy helper
# Usage: ./deploy.sh [cloudflare|github|preview]

set -e
cd "$(dirname "$0")"

MODE="${1:-preview}"

case "$MODE" in
  preview)
    echo "→ Локальный preview на http://localhost:8080"
    python3 -m http.server 8080
    ;;

  cloudflare)
    echo "→ Деплой на Cloudflare Pages"
    if ! command -v wrangler &> /dev/null; then
      echo "Устанавливаем Wrangler CLI…"
      npm install -g wrangler
    fi
    wrangler pages deploy . --project-name=moyvedi
    ;;

  github)
    echo "→ Подготовка GitHub Pages"
    if [ ! -d ".git" ]; then
      git init
      git branch -M master
    fi
    git add -A
    git commit -m "deploy: $(date +%Y-%m-%d_%H:%M)" || true
    if ! git remote get-url origin &> /dev/null; then
      echo "Введи URL GitHub-репо (например git@github.com:user/moyvedi.git):"
      read -r REPO_URL
      git remote add origin "$REPO_URL"
    fi
    git push -u origin master
    echo "✓ Запушено. Не забудь включить Pages в Settings → Pages → Source: GitHub Actions"
    ;;

  *)
    echo "Использование: ./deploy.sh [preview|cloudflare|github]"
    exit 1
    ;;
esac
