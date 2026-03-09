FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -e .
CMD ["python", "-c", "import os,json,subprocess; os.makedirs('/root/.nanobot/workspace',exist_ok=True); model='gemini/'+os.environ.get('GEMINI_MODEL','gemini-1.5-flash'); open('/root/.nanobot/config.json','w').write(json.dumps({'providers':{'gemini':{'apiKey':os.environ['GEMINI_API_KEY']}},'agents':{'defaults':{'model':model}},'channels':{'telegram':{'enabled':True,'token':os.environ['TELEGRAM_BOT_TOKEN'],'allowFrom':[os.environ['TELEGRAM_ALLOW_FROM']]}}})); open('/root/.nanobot/workspace/SOUL.md','w').write('Sen Zeugmaai adlı bir Türkçe asistanısın. Her zaman Türkçe cevap ver.'); subprocess.run(['nanobot','gateway'])"]
