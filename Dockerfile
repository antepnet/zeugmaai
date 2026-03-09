FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -e .
CMD ["python", "-c", "import os,json,subprocess; os.makedirs('/root/.nanobot',exist_ok=True); open('/root/.nanobot/config.json','w').write(json.dumps({'workspace':'/root/workspace','providers':{'groq':{'apiKey':os.environ['GROQ_API_KEY'],'baseUrl':'https://api.groq.com/openai/v1'}},'agents':{'defaults':{'model':'groq/'+os.environ.get('GROQ_MODEL','llama3-8b-8192'),'maxTokens':8192,'temperature':0.7}},'channels':{'telegram':{'enabled':True,'token':os.environ['TELEGRAM_BOT_TOKEN'],'allowFrom':[os.environ['TELEGRAM_ALLOW_FROM']]}}})); subprocess.run(['nanobot','gateway'])"]
