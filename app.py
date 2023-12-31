from flask import Flask
from flask_cors import CORS, cross_origin
from flask_jwt_extended import JWTManager
from flask_swagger_ui import get_swaggerui_blueprint
app = Flask(__name__)

app.config["JWT_SECRET_KEY"] = "iot_nhom9_2023"
jwt = JWTManager(app)
cors = CORS(app, resources={r"/*": {"origins": "*"}})

# swagger document
SWAGGER_URL = '/api/docs'
API_URL = 'http://petstore.swagger.io/v2/swagger.json'
swaggerui_blueprint = get_swaggerui_blueprint(
    SWAGGER_URL,  # Swagger UI static files will be mapped to '{SWAGGER_URL}/dist/'
    API_URL,
    config={  # Swagger UI config overrides
        'app_name': "Test application"
    },
    # oauth_config={  # OAuth config. See https://github.com/swagger-api/swagger-ui#oauth2-configuration .
    #    'clientId': "your-client-id",
    #    'clientSecret': "your-client-secret-if-required",
    #    'realm': "your-realms",
    #    'appName': "your-app-name",
    #    'scopeSeparator': " ",
    #    'additionalQueryStringParams': {'test': "hello"}
    # }
)

app.register_blueprint(swaggerui_blueprint)
