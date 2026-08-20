import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "¡Hola Mundo desde un entorno seguro!"

if __name__ == "__main__":
    TEST_TOKEN = os.getenv("GITHUB_PAT", "token_por_defecto_si_no_existe")
    # ✅ nosemgrep: Se requiere 0.0.0.0 para enlazar correctamente dentro del contenedor Docker
    app.run(host="0.0.0.0", port=8080) # nosemgrep
