from flask import Flask, render_template, request, redirect, session
import hashlib

app = Flask(__name__)
app.secret_key = 'supersecretkey'

def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

@app.route('/')
def home():
    return redirect('/login')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = hash_password(request.form['password'])
        with open('credentials.txt', 'a') as f:
            f.write(f'{username},{password}\n')
        return redirect('/login')
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = hash_password(request.form['password'])
        with open('credentials.txt', 'r') as f:
            for line in f:
                stored_user, stored_pass = line.strip().split(',')
                if username == stored_user and password == stored_pass:
                    session['username'] = username
                    return redirect('/dashboard')
    return render_template('login.html')

@app.route('/dashboard')
def dashboard():
    if 'username' not in session:
        return redirect('/login')
    return render_template('dashboard.html')

@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect('/login')

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=8080)
