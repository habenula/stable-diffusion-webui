FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    vim \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    libgl1 \
    libglib2.0-0 \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

WORKDIR /app

ENV PIP_CACHE_DIR=/app/.pipcache

ADD https://raw.githubusercontent.com/habenula/stable-diffusion-webui/refs/heads/with-extensions/webui.sh webui.sh

RUN chmod +x webui.sh

RUN bash webui.sh --exit

EXPOSE 7860

# но моделька все равно докачивается при первом запуске 
CMD ["bash", "-c", "chmod +x webui.sh && bash webui.sh --listen --port 7860 --models-dir /workspace/"]
