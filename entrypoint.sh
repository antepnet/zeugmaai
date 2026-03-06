#!/bin/bash
mkdir -p /root/.nanobot
cat > /root/.nanobot/config.json << EOF
{
  "providers": {
    "openrouter": {
      "apiKey": "$OPENROUTER_API_KEY"
    }
  },
  "agents": {
    "defaults": {
      "model": "minimax/minimax-m2"
    }
  },
  "channels": {
    "telegram": {
      "enabled": true,
      "token": "$TELEGRAM_BOT_TOKEN",
      "allowFrom": ["$TELEGRAM_ALLOW_FROM"]
    }
  }
}
EOF
nanobot gateway
