# Infraestrutura e DevOps para Bookmark App

Este repositório contém um ambiente completo para provisionamento, execução, monitoramento e automação da aplicação Bookmark, desenvolvida com o micro-framework Flask.

O objetivo é praticar e aplicar conceitos reais de Administração de Sistemas, Infraestrutura como Código e DevOps, indo desde o desenvolvimento local até práticas modernas como provisionamento automático, monitoramento com Prometheus e Grafana, CI/CD com GitHub Actions, containerização com Docker, entre outras tecnologias que serão incorporadas ao longo do tempo.

## Stack aplicada

Stack da aplicação | Stack da infraestrutura local
:---: | :---:
Python | Linux (Ubuntu 20.04)
Flask | Vagrant
SQLite (via SQLAlchemy) | VirtualBox
HTML + CSS | Bash Script
Jinja2 | Gunicorn
-- | Nginx *(Proxy Reverse)*


*(Em atualização contínua...)*

## Tudo começa em produção - fase 1

Ao criar esse repositório, eu não sabia o que colocar na minha infraestrutura local para continuar a  evoluir as minhas habilidades em DevOps: cultura, prática e ferramentas; então decidi desenvolver uma app usando Flask para testar cada conhecimento adquirido. Como tudo começa em produção, antes de avançar para qualquer nível técnico, devemos ter a certeza que a nossa aplicação está funcional, isso é, rodando em produção. Nesta primeira fase, para simular um ambiente real de produção, fiz questão de usar o Vagrant, VirtualBox e scripts em Bash para provisionar o meu servidor que simula a produção. Para puderes usar esse ambiente na tua própria máquina deves seguir os passos abaixo:

### 1. Instalar o Vagrant

Para instalar o vagrant na sua máquina, você pode seguir o tutorial para instalação no seguinte link: [Vagrant Install](https://developer.hashicorp.com/vagrant/install); é super rápido. E se quiseres ter uma noção rápida sobre o vagrant, visite: [Vagrant Tutorial](https://developer.hashicorp.com/vagrant/tutorials/get-started)

E certifique-se de ter o VirtualBox instalado na tua máquina.

### 2. Clonar o repositório

Após instalar o Vagrant e ter o VirtualBox instalado na tua máquina, você deve clonar este repositório:

```bash
git clone https://github.com/Mateus-Sebastiao/infra-bookmark-devops.git
```
 
A seguir, você pode adicionar a box vagrant do Ubuntu/focal64 na sua máquina ou executar o Vagrantfile diretamente, porém, executar o Vagrantfile sem adicionar a box na sua máquina, fará com que o ficheiro faça download dessa box toda vez que quiseres rodar um ambiente; para rodar o ambiente, digite:

```bash
vagrant box add ubuntu/focal64
vagrant up
```

### 3. Funcionamento, etapas do provisionamento e resultado

Após rodar o `vagrant up`, o ambiente estará ativado; você poderá acessar a app Flask via navegador digitando: `http://192.168.56.10/` - *(O IP pode ser modificado no Vagrantfile)*.

<div align="center">
    <img src="./media/app-Flask-in-provisioning.gif" alt="Demonstração" width="700" height="336">
</div>

Acima tem o projeto funcionando; as etapas do provisionamento englobam:

1. Criação da VM Vagrant
2. Provisionamento automatizado usando o [script de provisionamento](./provision.sh)
    - Instalação de pacotes essenciais (Python, Pip, Nginx, etc.)
    - Clonagem do repositório;
    - Criação do ambiente virtual e instalação de dependências
    - Configuração do **Nginx** como proxy reverso | [arquivo de configuração](./nginx.conf)
    - Configuração do **Gunicorn** como serviço systemd | [arquivo de configuração](./gunicorn.service)

