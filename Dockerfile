FROM python:3.14.7-alpine3.23

WORKDIR /usr/src/app

COPY pyproject.toml README.md ./
COPY src ./src
RUN pip install --no-cache-dir . && \
    rm requirements.txt && \
    mkdir etc

# Copy the application code

CMD ["python", "-m", "prometheus_eaton_ups_exporter", "-k", "-v", "-c", "/usr/src/app/etc/config.json", "-w", "0.0.0.0:9795"]
