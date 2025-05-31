from flask import Blueprint, render_template, request, redirect, url_for
from . import db
from .models import Bookmark

bp = Blueprint('main', __name__)

@bp.route('/')
def index():
    bookmarks = Bookmark.query.order_by(Bookmark.created_at.desc()).all()
    return render_template('index.html', bookmarks=bookmarks)

@bp.route('/add', methods=['POST'])
def add_bookmark():
    title = request.form.get('title')
    url = request.form.get('url')
    
    if title and url:
        new_bookmark = Bookmark(title=title, url=url)
        db.session.add(new_bookmark)
        db.session.commit()
    
    return redirect(url_for('main.index'))
