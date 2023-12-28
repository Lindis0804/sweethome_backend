import pymysql
import hashlib
from app import *
from utils.db import mysql
from utils.db import connectPostgres
from flask import jsonify
from flask import request

from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_jwt_extended import JWTManager
# from werkzeug.security import generate_password_hash, check_password_hash


@app.route("/login", methods=["POST"])
def login():
    conn = None
    cursor = None
    try:
        email = request.json.get("email", None)
        password = request.json.get("password", None)
        if email != None and password != None and request.method == 'POST':
            # Check if account exists
            hash_pass = hashlib.sha256(password.encode('utf-8')).hexdigest()
            # conn = mysql.connect()
            cursor = connectPostgres.cursor(pymysql.cursors.DictCursor)
            cursor.execute(
                'SELECT * FROM users WHERE email = %s AND password= %s AND role=%s', (email, hash_pass, 0))
            # Fetch one record and return result
            user = cursor.fetchone()
            if user:
                access_token = create_access_token(identity=email)
                # can pass identity = {"email": email}
                return jsonify(access_token=access_token)
            else:
                return jsonify({'message': "Wrong email or password"}), 401
    except Exception as e:
        print(e)
    finally:
        cursor.close()
        conn.close()


@app.route("/login_user", methods=["POST"])
def loginUser():
    conn = None
    cursor = None
    try:
        email = request.json.get("email", None)
        password = request.json.get("password", None)
        if email != None and password != None and request.method == 'POST':
            # Check if account exists
            hash_pass = hashlib.sha256(password.encode('utf-8')).hexdigest()
            # conn = mysql.connect()
            conn = connectPostgres()
            cursor = conn.cursor()
            cursor.execute(
                'SELECT * FROM users WHERE email = %s AND password= %s AND role=%s', (email, hash_pass, 1))
            # Fetch one record and return result
            user = cursor.fetchone()
            if user:
                access_token = create_access_token(
                    identity=email, expires_delta=False)
                # can pass identity = {"email": email}
                return jsonify(access_token=access_token)
            else:
                return jsonify({'message': "Wrong email or password"}), 401
    except Exception as e:
        res = jsonify({
            "success":False,
            "message":[e]
        })
        res.status_code = 500
        print(e)
        return res
    finally:
        cursor.close()
        conn.close()
