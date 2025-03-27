#!/bin/bash

# Update and upgrade system
sudo apt update -y && sudo apt upgrade -y

# Install necessary packages
sudo apt install git python3-pip -y

# Clone the project repository
git clone https://github.com/ebenhamu/MARSQA_demo

cd MARSQA_demo

# Install Python dependencies
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt --break-system-packages --ignore-installed

touch /home/ubuntu/MARSQA_demo/.env
# Set proper permissions
sudo chmod -R 777 .

# Create a systemd service file for MoniTHOR
sudo bash -c 'cat << EOF > /etc/systemd/system/clock.service
[Unit]
Description=clock  Flask application for mars qa
After=network.target

[Service]
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/MARSQA_demo
EnvironmentFile=/home/ubuntu/MARSQA_demo/.env
ExecStart=/usr/bin/python3 /home/ubuntu/MARSQA_demo/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd daemon to register the service
sudo systemctl daemon-reload

# Start and enable the MoniTHOR service
sudo systemctl start clock.service
sudo systemctl enable clock.service

# Stop UFW if necessary (consider configuring it properly instead of disabling)
sudo ufw disable


# run in terminl the commend: "curl  | sh" 
