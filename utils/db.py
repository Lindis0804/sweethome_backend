from app import app
from flaskext.mysql import MySQL
import os
from dotenv import load_dotenv
import psycopg2
mysql = MySQL()
load_dotenv()
app.config['MYSQL_DATABASE_USER'] = os.getenv("MYSQL_DATABASE_USER")
app.config['MYSQL_DATABASE_PASSWORD'] = os.getenv("MYSQL_DATABASE_PASSWORD")
app.config['MYSQL_DATABASE_DB'] = os.getenv("MYSQL_DATABASE_DB")
app.config['MYSQL_DATABASE_HOST'] = os.getenv("MYSQL_DATABASE_HOST")

mysql.init_app(app)

def connectPostgres():
 return  psycopg2.connect(
        host=os.getenv("POSTGRES_HOST"),
        database=os.getenv("POSTGRES_DB"),
        user=os.getenv("POSTGRES_USER"),
        password=os.getenv("POSTGRES_PASSWORD")
    )
