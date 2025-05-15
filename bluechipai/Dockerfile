# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.12-slim

# Install necessary system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add Scarb to PATH
ENV PATH="/root/.local/bin:/root/.scarb/bin:${PATH}"

# Install Scarb in a specific directory
RUN curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | bash -s -- -v 2.11.4

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED=True

# Set environment variables
# PYTHONUNBUFFERED. Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED=True \
    APP_HOME=/app

# Set work directory
WORKDIR $APP_HOME

# Copy and install Python dependencies
COPY requirements.txt ./

# Create a virtual environment for Python
RUN python -m venv /opt/venv

# Configure the PATH to use the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies in the virtual environment
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . ./

# Prepare entrypoint script
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

# Compile Cairo functions using Scarb
RUN cd /app/cairo/model_btc && scarb build
RUN cd /app/cairo/model_eth && scarb build

# Use entrypoint script
CMD ["./entrypoint.sh"]