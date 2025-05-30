# Ambiente de laboratório pessoal usando Vagrant e VirtualBox para simular uma infraestrutura real com foco em práticas de DevOps.

Este repositório contém meus experimentos práticos com Vagrant para automatizar a criação de máquinas virtuais e simular ambientes semelhantes aos de produção. Serve como base para praticar servidores web, aplicações web, bancos de dados e, futuramente, explorar conteinerização, provisionamento com Ansible e fluxos de trabalho de deploy.

## Instalando o Vagrant

Tudo começa em produção; essa é a frase que me caracteriza até ao momento. Decidi simular uma infraestrutura real em práticas de DevOps usando Vagrant e VirtualBox, quero puder entender, automatizar e resolver problemas de forma profissional. Se tu quiseres saber mais sobre o vagrant, aí está o link para documentação: [Hashicorp-Vagrant-Docs](https://developer.hashicorp.com/vagrant/docs)

Bem, instalar o Vagrant na tua máquina é muito simples, basta seguires as diretrizes neste link: [Hashicorp-Vagrant-Install](https://developer.hashicorp.com/vagrant/install)

## Configurando o ambiente

### Pré-requisitos

Para continuares a me seguir nesta jornada, você deve ter:
- Vagrant CLI instalado na tua máquina
- VirtualBox instalado como seu provedor de virtualização

### Adicionando Vagrant Box

Aqui começamos a ver o poder do Vagrant. Ao invés de construir uma máquina virtual do zero, o que seria um processo lento e tedioso, o Vagrant usa uma imagem base para clonar rapidamente uma máquina virtual. Essas imagens base são conhecidas como "boxes" no Vagrant.

Adicionei Vagrant box ubuntu/focal64 na minha máquina com o comando:
```bash
vagrant box add ubuntu/focal64
```

Mas você pode usar a que melhor se adequa aos seus objectivos; procure em: [Vagrant-Cloud](https://portal.cloud.hashicorp.com/vagrant/discover/)

