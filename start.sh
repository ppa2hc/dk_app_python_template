#!/bin/sh

echo "Start User App"
# start local mqtt server
mosquitto -d
cd /home
python main.py
echo "End User App"

tail -f /dev/null
