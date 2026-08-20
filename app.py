import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "¡Hola Mundo desde un entorno seguro!"

if __name__ == "__main__":
    # Leer el token de forma segura desde variables de entorno
    TEST_TOKEN = os.getenv("GITHUB_PAT", "token_por_defecto_si_no_existe")
    app.run(host="0.0.0.0", port=5000)
