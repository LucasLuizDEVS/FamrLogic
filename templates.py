from flask import Flask, render_template

@app.route('/')

def home():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Fazenda")
    fazendas = cursor.fetchall()
    conn.close()

    return render_template('home.html', fazendas=fazendas)
