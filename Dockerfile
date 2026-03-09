FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -e .
CMD ["python", "-c", "import os,json,subprocess; os.makedirs('/root/.nanobot',exist_ok=True); open('/root/.nanobot/config.json','w').write(json.dumps({'providers':{'openrouter':{'apiKey':os.environ['OPENROUTER_API_KEY']}},'agents':{'defaults':{'model':'openrouter/free'}},'channels':{'telegram':{'enabled':True,'token':os.environ['TELEGRAM_BOT_TOKEN'],'allowFrom':[os.environ['TELEGRAM_ALLOW_FROM']]}}})); subprocess.run(['nanobot','gateway'])"]
