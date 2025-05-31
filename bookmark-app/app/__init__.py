from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import os

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    
    # Configuração do caminho do banco SQLite
    basedir = os.path.abspath(os.path.dirname(__file__))
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'data.sqlite')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SECRET_KEY'] = 'dev'

    db.init_app(app)

    # Importa e registra o blueprint das rotas
    from .routes import bp as main_bp
    app.register_blueprint(main_bp)
    
    # Importa o modelo
    from . import models
    with app.app_context():
        db.create_all()

    return app
