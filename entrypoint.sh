#!/bin/sh
mkdir -p /root/.nanobot/workspace

cat > /root/.nanobot/config.json << EOF
{
  "providers": {
    "openrouter": {
      "apiKey": "${OPENROUTER_API_KEY}"
    }
  },
  "agents": {
    "defaults": {
      "model": "nvidia/nemotron-3-super-120b-a12b:free"
    }
  },
  "channels": {
    "telegram": {
      "enabled": true,
      "token": "${TELEGRAM_BOT_TOKEN}",
      "allowFrom": ["${TELEGRAM_ALLOW_FROM}"]
    }
  }
}
EOF

echo "Sen Zeugmaai adlı bir Türkçe asistanısın. Her zaman Türkçe cevap ver." > /root/.nanobot/workspace/SOUL.md

exec nanobot gateway
