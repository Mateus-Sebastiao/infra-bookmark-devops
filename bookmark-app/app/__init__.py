from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import os
from dotenv import load_dotenv

# Carrega variáveis de ambiente do arquivo .env
load_dotenv()

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)

    # Lê variáveis de ambiente
    MYSQL_USER = os.getenv('MYSQL_USER')
    MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD')
    MYSQL_HOST = os.getenv('MYSQL_HOST', 'localhost')  # fallback se não for definido
    MYSQL_DB = os.getenv('MYSQL_DB')
    
    # Configuração do caminho do banco MySQL
    app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}/{MYSQL_DB}'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'dev')

    db.init_app(app)

    # Importa e registra o blueprint das rotas
    from .routes import bp as main_bp
    app.register_blueprint(main_bp)
    
    # Importa o modelo
    from . import models
    with app.app_context():
        db.create_all()

    return app
