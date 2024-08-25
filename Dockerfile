# First stage: Build dependencies in a full Python environment
#FROM python:3.12-bookworm AS python-builder
FROM python:3.12-alpine AS python-builder

WORKDIR /home/

# Install necessary packages for building the environment
#RUN apt-get update && apt-get install -y git make
RUN apk add --no-cache git g++ make

# Install Python dependencies into a specific directory
COPY sdk-requirements.txt /home/
COPY app-requirements.txt /home/
RUN pip install --no-cache-dir --target /home/python-packages/ -r sdk-requirements.txt
RUN pip install --no-cache-dir --target /home/python-packages/ -r app-requirements.txt

# Second stage: Create a minimal runtime environment
FROM python:3.12-alpine AS target
#FROM ubuntu:24.04 AS target

WORKDIR /home/

# Copy the Python packages from the builder stage to the Alpine image
COPY --from=python-builder /home/python-packages/ /home/python-packages/

# (Optional) If the Python packages include compiled extensions, you might need to install some dependencies in Alpine:
RUN apk add --no-cache mosquitto
#RUN apt-get update && apt-get install -y mosquitto python3

# Copy application files
COPY start.sh /home/
COPY main.py /home/

# Set execute permission for the script
RUN chmod +x /home/start.sh

# Make links
RUN ln -s /home/python-packages/velocitas_sdk /home/python-packages/sdv

# Set environment variables
ENV PYTHONPATH=$PYTHONPATH:/home/vss/vehicle_gen/:/home/python-packages/
ENV SDV_VEHICLEDATABROKER_ADDRESS="grpc://vehicledatabroker:55555"

# Execute the script
CMD ["/home/start.sh"]
