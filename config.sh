#!/bin/bash
set -e  # para detenerse si hay errores

sudo yum update -y

sudo yum install -y git python3

cd /home/ubuntu
if [ ! -d "tallerEC2" ]; then
  git clone https://github.com/Miguel-Machado85/RepoTallerEC2.git
fi
cd tallerEC2

python3 -m venv venv
source venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

sudo cp servicio-api.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable servicio-api.service
sudo systemctl start servicio-api.service