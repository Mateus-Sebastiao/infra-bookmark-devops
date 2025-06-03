#!/bin/bash

# Home do usuário
MY_HOME="/home/vagrant"

# Variáveis para o nginx
APP_CONF="bookmark"
CONF_PATH="/etc/nginx/sites-available/$APP_CONF"

set -e  # Encerra o script se qualquer comando falhar
set -o pipefail  # Garante que falhas em pipes sejam capturada

# Atualizar repositórios e instalar Python3, pip, venv, nginx...
echo ">> Atualizando sistema e instalando Python, venv e pip..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3 python3-venv python3-pip nginx

# Clonar repositório
echo ">> Clonando repositório do projeto..."
if [ ! -d "infra-bookmark-devops" ]; then
  git clone https://github.com/Mateus-Sebastiao/infra-bookmark-devops.git
fi

# Corrigir propriedade do diretório para o usuário vagrant
sudo chown -R vagrant:vagrant "$MY_HOME/infra-bookmark-devops"
cd infra-bookmark-devops/bookmark-app/

echo ">> Criando ambiente virtual..."
python3 -m venv venv
sudo chown -R vagrant:vagrant venv/

echo ">> Instalando dependências do projeto..."
sudo -u vagrant ./venv/bin/pip install -r requirements.txt

echo ">> Configurando o nginx como proxy reverso..."
if [ -f "$MY_HOME/infra-bookmark-devops/nginx.conf" ]; then
  sudo cp "$MY_HOME/infra-bookmark-devops/nginx.conf" "$CONF_PATH"
else
  echo "Arquivo nginx.conf não encontrado em $MY_HOME/infra-bookmark-devops/"
  exit 1
fi

if [ ! -L "/etc/nginx/sites-enabled/$APP_CONF" ]; then
  sudo ln -s "$CONF_PATH" /etc/nginx/sites-enabled/
fi

if [ -L "/etc/nginx/sites-enabled/default" ]; then
  sudo rm /etc/nginx/sites-enabled/default
fi

echo ">> Validando e reiniciando o Nginx..."
sudo nginx -t && sudo systemctl restart nginx

echo ">> Configurando Gunicorn como serviço systemd..."
if [ -f "$MY_HOME/infra-bookmark-devops/gunicorn.service" ]; then
  sudo cp "$MY_HOME/infra-bookmark-devops/gunicorn.service" /etc/systemd/system/gunicorn.service
else
  echo "Arquivo gunicorn.service não encontrado em $MY_HOME/infra-bookmark-devops/"
  exit 1
fi

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

echo ">> Provisionamento concluído com sucesso!"