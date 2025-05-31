#!/bin/bash

set -e  # Encerra o script se qualquer comando falhar
set -o pipefail  # Garante que falhas em pipes sejam capturada

# Atualizar repositórios e instalar Python3, pip e venv
echo ">> Atualizando sistema e instalando Python, venv e pip..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3 python3-venv python3-pip

# Clonar repositório
echo ">> Clonando repositório do projeto..."
if [ ! -d "vagrant-lab" ]; then
  git clone https://github.com/Mateus-Sebastiao/vagrant-lab.git
fi

# Corrigir propriedade do diretório para o usuário vagrant
chown -R vagrant:vagrant /home/vagrant/vagrant-lab
cd vagrant-lab/bookmark-app/

# Configurando o ambiente virtual
echo ">> Criando ambiente virtual..."
python3 -m venv venv
source venv/bin/activate

# Instalando as dependências
echo ">> Instalando dependências do projeto..."
pip install -r requirements.txt

echo ">> Provisionamento concluído com sucesso!"