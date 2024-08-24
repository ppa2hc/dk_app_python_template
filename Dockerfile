FROM python:3.12-alpine

# Install required binaries/libs
RUN apk update && apk add --no-cache mosquitto

# Install python libs
COPY requirements.txt /home/
RUN pip install -r /home/requirements.txt

# Copy files into the container
COPY start.sh /home/
COPY main.py /home/

# Set execute permission for the script
RUN chmod +x /home/start.sh

# Install the necessary Python packages

# Set var env
ENV PYTHONPATH=$PYTHONPATH:/home/vss/dk_system/lib/python3.12/site-packages/:/home/vss/vehicle_gen/
ENV SDV_VEHICLEDATABROKER_ADDRESS="grpc://vehicledatabroker:55555"

# Execute the script
CMD ["/home/start.sh"]
