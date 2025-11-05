#!/bin/bash
set -e  # para detenerse si hay errores

sudo apt update -y

sudo apt install -y git python3

cd /home/ubuntu
if [ ! -d "tallerEC2" ]; then
  git clone https://github.com/Miguel-Machado85/RepoTallerEC2.git
fi
cd tallerEC2/RepoTallerEC2

python3 -m venv venv
source venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

sudo cp fastapi_srv.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable fastapi_srv.service
sudo systemctl start fastapi_srv.service