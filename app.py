from flask import Flask, jsonify, render_template, request, redirect, session, url_for, flash
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
import pyodbc

app = Flask(__name__)
app.secret_key = 'farm_logic_secret_key_2026' # Chave necessária para sessões

# ==========================================
# CONEXÃO COM SQL SERVER
# ==========================================
def get_db_connection():
    return pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost\\SQLEXPRESS;"
        "DATABASE=FarmLogic;"
        "Trusted_Connection=yes;"
    )

# ==========================================
# PORTEIRO DE LOGIN (CORRIGIDO)
# ==========================================
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'usuario_id' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

# ==========================================
# LOGIN (CORRIGIDO)
# ==========================================
@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM Usuario WHERE username = ?", (username,))
        usuario = cursor.fetchone()
        conn.close()

        # Verifica usuário e senha (usando comparação direta por enquanto conforme seu setup)
        if usuario and usuario.senha_hash == password:
            session['usuario_id'] = usuario.Id
            session['usuario_nome'] = usuario.nome
            session['perfil'] = usuario.perfil
            return redirect('/')
        else:
            flash('Usuário ou senha inválidos')
    
    return render_template('login.html')
    
@app.route('/logout')
def logout():
    session.clear()
    return redirect('/login')

# ==========================================
# LISTAGEM DE FAZENDAS (PROTEGIDA)
# ==========================================
@app.route('/')
@login_required
def index():
    conexao = get_db_connection()
    cursor = conexao.cursor()
    cursor.execute("SELECT * FROM Fazenda ORDER BY Id")
    
    colunas = [column[0] for column in cursor.description]
    fazendas = [dict(zip(colunas, row)) for row in cursor.fetchall()]
    
    cursor.close()
    conexao.close()
    return render_template('index.html', fazendas=fazendas)

# ==========================================
# DETALHES DA FAZENDA (PROTEGIDA)
# ==========================================
@app.route('/fazenda/<int:id>')
@login_required
def detalhes_fazenda(id):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("""
                   SELECT F.nome, F.localizacao, F.hectares, P.nome AS nome_proprietario,
                   P.cpf_cnpj, P.telefone
                   FROM Fazenda F
                   LEFT JOIN Proprietario P ON F.Id_proprietario = P.Id
                   WHERE F.Id = ?
                   """, (id,))
    fazenda = cursor.fetchone()

    cursor.execute("SELECT nome, area, tipo_solo FROM Talhao WHERE Id_fazenda = ?", (id,))
    talhoes = cursor.fetchall()

    conn.close()
    return render_template('detalhes_fazenda.html', fazenda=fazenda, talhoes=talhoes)

# ==========================================
# NOVA FAZENDA (PROTEGIDA)
# ==========================================
@app.route('/nova-fazenda', methods=['GET'])
@login_required
def nova_fazenda():
    return render_template('nova_fazenda.html')

@app.route('/nova-fazenda', methods=['POST'])
@login_required
def salvar_fazenda():
    nome = request.form['nome']
    localizacao = request.form['localizacao']
    hectares = request.form['hectares']

    conexao = get_db_connection()
    cursor = conexao.cursor()
    cursor.execute("INSERT INTO Fazenda (nome, localizacao, hectares) VALUES (?, ?, ?)", (nome, localizacao, hectares))
    conexao.commit()
    cursor.close()
    conexao.close()
    return redirect('/')

# ==========================================
# EXECUÇÃO
# ==========================================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
