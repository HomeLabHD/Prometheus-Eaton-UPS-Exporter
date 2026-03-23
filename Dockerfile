FROM python:3.14.3-alpine3.23

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt && \
    rm requirements.txt && \
    mkdir etc

# Copy the application code
COPY prometheus-eaton-ups-exporter prometheus_eaton_ups_exporter

CMD ["python", "-m", "prometheus_eaton_ups_exporter", "-k", "-v", "-c", "/usr/src/app/etc/config.json", "-w", "0.0.0.0:9795"]
