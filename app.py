# 1. IMPORTAÇÃO
# O Flask é o que faz o servidor rodar. 
# O 'jsonify' é para transformar os dados do banco em formato JSON (padrão web).
from flask import Flask, jsonify, render_templates
import pyodbc 

app = Flask(__name__)

# 2. CONFIGURAÇÃO DA CONEXÃO
# Guardamos a string de conexão em uma variável para facilitar.
def get_db_connection():
    return pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost\\SQLEXPRESS;"
        "DATABASE=FarmLogic;"
        "Trusted_Connection=yes;"
    )

# 3. ROTA (ENDPOINT)
# O '@app.route' define um endereço no seu sistema.
@app.route('/fazendas', methods=['GET']) 
def listar_fazendas():
    conexao = get_db_connection()
    cursor = conexao.cursor()
    
    # Executamos o SQL que você já criou
    cursor.execute("SELECT * FROM Fazenda")
    
    # 'fetchall' busca todas as linhas da consulta
    colunas = [column[0] for column in cursor.description]
    resultados = [dict(zip(colunas, row)) for row in cursor.fetchall()]
    
    cursor.close()
    conexao.close()
    
    # Retornamos os dados em formato JSON
    return jsonify(resultados)

# 4. EXECUÇÃO
# Esse comando faz o servidor iniciar no seu computador
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000,debug=True)
