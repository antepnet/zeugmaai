#!/bin/sh

mkdir -p /root/.nanobot/workspace

cat > /root/.nanobot/config.json << EOF
{
  "providers": {
    "custom": {
      "apiKey": "${ZAI_API_KEY}",
      "apiBase": "https://api.z.ai/api/paas/v4"
    }
  },
  "agents": {
    "defaults": {
      "model": "glm-4.7-flash"
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
