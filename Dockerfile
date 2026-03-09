FROM python:3.11-slim

WORKDIR /app
COPY . .

# Güvenlik: non-root kullanıcı oluştur
RUN groupadd -r nanobot && useradd -r -g nanobot nanobot

# Bağımlılıkları kur ve cache temizle
RUN pip install --no-cache-dir -e . && \
    rm -rf /root/.cache/pip

# Config dizini için izinler (non-root için)
RUN mkdir -p /home/nanobot/.nanobot && \
    chown -R nanobot:nanobot /home/nanobot /app

# Non-root kullanıcıya geç
USER nanobot
ENV HOME=/home/nanobot

# Config path environment variable
ENV CONFIG_PATH=/home/nanobot/.nanobot/config.json

CMD ["sh", "-c", "\
python3 -c \"\
import os, json, sys; \
groq_key = os.environ.get('GROQ_API_KEY'); \
telegram_token = os.environ.get('TELEGRAM_BOT_TOKEN'); \
allow_from = os.environ.get('TELEGRAM_ALLOW_FROM'); \
\
if not groq_key or not telegram_token or not allow_from: \
    print('HATA: GROQ_API_KEY, TELEGRAM_BOT_TOKEN ve TELEGRAM_ALLOW_FROM gerekli!', file=sys.stderr); \
    sys.exit(1); \
\
config = {\
    'workspace': '/home/nanobot/workspace',\
    'providers': {\
        'groq': {\
            'apiKey': groq_key,\
            'baseUrl': 'https://api.groq.com/openai/v1'\
        }\
    },\
    'agents': {\
        'defaults': {\
            'model': 'groq/' + os.environ.get('GROQ_MODEL', 'llama3-8b-8192'),\
            'maxTokens': int(os.environ.get('MAX_TOKENS', '8192')),\
            'temperature': float(os.environ.get('TEMPERATURE', '0.7')),\
            'maxToolIterations': int(os.environ.get('MAX_TOOL_ITERATIONS', '10'))\
        }\
    },\
    'channels': {\
        'telegram': {\
            'enabled': True,\
            'token': telegram_token,\
            'allowFrom': [allow_from]\
        }\
    }\
}; \
\
os.makedirs('/home/nanobot/workspace', exist_ok=True); \
with open(os.environ['CONFIG_PATH'], 'w') as f: \
    json.dump(config, f, indent=2); \
print('Config oluşturuldu:', os.environ['CONFIG_PATH'])\
\" && \
exec nanobot gateway\
"]
