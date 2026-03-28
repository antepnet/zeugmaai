RUN printf '#!/bin/sh\n\
mkdir -p /root/.nanobot/workspace\n\
cat > /root/.nanobot/config.json << EOF\n\
{\n\
  "providers": {\n\
    "openai": {\n\
      "apiKey": "${ZAI_API_KEY}",\n\
      "apiBase": "https://api.z.ai/api/paas/v4"\n\
    }\n\
  },\n\
  "agents": {\n\
    "defaults": {\n\
      "model": "openai/glm-4.7-flash"\n\
    }\n\
  },\n\
  "channels": {\n\
    "telegram": {\n\
      "enabled": true,\n\
      "token": "${TELEGRAM_BOT_TOKEN}",\n\
      "allowFrom": ["${TELEGRAM_ALLOW_FROM}"]\n\
    }\n\
  }\n\
}\n\
EOF\n\
echo "Sen Zeugmaai adlı bir Türkçe asistanısın. Her zaman Türkçe cevap ver." > /root/.nanobot/workspace/SOUL.md\n\
exec nanobot gateway\n\
' > /app/entrypoint.sh && chmod +x /app/entrypoint.sh
