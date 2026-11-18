# Universal Protection Theory: G-Mesh Distributed Swarm Node (Canon Edition v4.6)
FROM python:3.11-slim

LABEL maintainer="Samuel Tobias Croydon-McRae <mcrae.tobias@gmail.com>"
LABEL description="Machine-Checked Canon Edition (v4.6) G-Mesh Sovereign Runtime"
LABEL doi="10.5281/zenodo.23965850"

ENV DEBIAN_FRONTEND=non-interactive
ENV PYTHONUNBUFFERED=1
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -e .

EXPOSE 8443

ENTRYPOINT ["python3", "-m", "gmesh.daemon"]
