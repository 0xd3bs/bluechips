import sys
import os

# Ensure the root directory of the project is in the PYTHONPATH
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(project_root)

from flask import Flask
from data_fetcher import get_data
from model_runner import run_model
from utils import standard_response
from routes import api_v1

# Check if the environment is set to debug
DEBUG = os.getenv("DEBUG", "false").lower() == "true"

app = Flask(__name__)

app.register_blueprint(api_v1)

if __name__ == "__main__":
    app.run()
