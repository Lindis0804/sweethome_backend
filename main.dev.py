
from app import *
from controllers.device import *
from controllers.login import login
from controllers.user import *
from controllers.room import *
from controllers.house import *
from controllers.control import *


@app.route('/', methods=['GET', 'POST'])
def index():
    return "Welcome to Arena of Valor."


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug='on')
