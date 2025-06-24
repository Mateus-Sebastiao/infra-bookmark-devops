# Colocando em Produção

Esse estágio do projeto foca em colocar o software em produção, começarei por fazer o mais difícil, kkk. Colocar tudo a rodar e a funcionar. Colocarei o software a funcionar numa infraestrutura tradicional; configurações e instalações manuais, servidores e tais. As tecnologias base serão: Vagrant, servidor Ubuntu, o software, banco de dados...

## Diagrama da arquitectura

<div align="center">
    <img src="./media/on-premises-diagram.png" alt="Diagrama da arquitectura da infraestrutura" width="700" height="336">
</div>

## Requsitos

- Vagrant
- VirtualBox

## Configurando dependências do Servidor do Banco de Dados MySQL

Após rodar o `vagrant up` para provisionar duas máquinas para nossa infraestrutura com base no **Vagrantfile**, chegou a hora de instalar as dependências de cada servidor. Começarei pelo servidor de banco de dados MySQL, para acessá-lo use: `vagrant ssh db`.

Com acesso nele, execute os seguintes comandos:

1. Atualizar os repositórios:
```bash
sudo apt-get update
```

2. Instalar o servidor:
```bash
sudo apt-get install mysql-server
```

3. Configurar acesso de qualquer endereço:
```bash
sudo nano /etc/mysql/conf.d/allow_external.cnf
```

Insira esse informação: 
> [mysqld]
    bind-address = 0.0.0.0

4. Reiniciar o servidor:
```bash
sudo systemctl restart mysql.service
```

5. Alterar modo de autenticação do usuário root:
```bash
sudo mysql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'senha123';
FLUSH PRIVILEGES;
EXIT;
```

6. Criando o banco de dados e eliminando o usuário anónimo padrão:
```bash
mysqladmin -u root -p create bookmark_schema
mysql -u root -p -e "SHOW DATABASES;"
mysql -u root -p -e "DELETE FROM mysql.user WHERE user=''; FLUSH PRIVILEGES;"
```

7. Melhorando a segurança criando o usuário "mateus" com privilégios total ao banco de dados
```bash
mysql -u root -p -e "CREATE USER 'mateus'@'%' IDENTIFIED BY 'bookmarksecret';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON bookmark_schema.* TO 'mateus'@'%';"
```