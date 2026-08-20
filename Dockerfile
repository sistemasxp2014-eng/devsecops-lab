# checkov:skip=CKV2_DOCKER_2: No se requiere healthcheck para este laboratorio de desarrollo
FROM python:3.11-slim
WORKDIR /app
RUN useradd -m appuser
COPY app/ /app/
RUN pip install --no-cache-dir -r requirements.txt
USER appuser
EXPOSE 8080
CMD ["python", "app.py"]
