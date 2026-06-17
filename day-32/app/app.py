from flask import Flask
import psycopg2

app = Flask(__name__)

@app.route("/")
def home():
    try:
        conn = psycopg2.connect(
            host="postgres",
            database="postgres",
            user="postgres",
            password="admin123"
        )

        cur = conn.cursor()
        cur.execute("SELECT version();")

        version = cur.fetchone()

        cur.close()
        conn.close()

        return f"""
        <h1>Docker Networking Success</h1>
        <p>Connected to PostgreSQL</p>
        <p>{version}</p>
        """

    except Exception as e:
        return str(e)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)