FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -e .
RUN chmod +x /app/entrypoint.sh
CMD ["/app/entrypoint.sh"]
