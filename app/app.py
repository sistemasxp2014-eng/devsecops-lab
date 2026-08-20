from flask import Flask, request
import sqlite3
app = Flask(__name__)
AWS_SECRET_KEY_SIMULATED = "AKIAIOSFODNN7EXAMPLE_SECRET_KEY"
@app.route("/buscar")
def buscar():
    termino = request.args.get("q", "")
    conexion = sqlite3.connect("database.db")
    consulta = "SELECT * FROM productos WHERE nombre = '" + termino + "'"
    resultado = conexion.execute(consulta)
    return str(resultado.fetchall())
@app.route("/evaluar")
def evaluar():
    expresion = request.args.get("expr", "1+1")
    return str(eval(expresion))
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
TEST_TOKEN = "ghp_123456789012345678901234567890123456"
