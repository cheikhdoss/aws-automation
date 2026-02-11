from flask import Flask, request, render_template
import base64
import requests
import os
from dotenv import load_dotenv

load_dotenv()  # Charge les variables du fichier .env

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("form.html")

@app.route("/trigger", methods=["POST"])
def trigger_pipeline():
    github_token = os.getenv("GITHUB_TOKEN")  # Token depuis variable d'environnement
    owner = "cheikhdoss"
    repo = "aws-automation"
    workflow_file = "terraform.yml"
    
    url = f"https://api.github.com/repos/{owner}/{repo}/actions/workflows/{workflow_file}/dispatches"
    
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {github_token}",
        "X-GitHub-Api-Version": "2022-11-28"
    }
    
    uploaded_file = request.files.get("html_file")
    if not uploaded_file or uploaded_file.filename.strip() == "":
        return "❌ Erreur: fichier HTML manquant", 400

    file_bytes = uploaded_file.read()
    if not file_bytes:
        return "❌ Erreur: fichier HTML vide", 400

    html_base64 = base64.b64encode(file_bytes).decode("utf-8")
    bucket_name = request.form["bucket_name"]

    data = {
        "ref": "main",
        "inputs": {
            "bucket_name": bucket_name,
            "html_object_key": "index.html",
            "html_base64": html_base64
        }
    }
    
    response = requests.post(url, json=data, headers=headers)

    # GitHub renvoie 204 (No Content) quand le workflow est déclenché avec succès
    if response.status_code == 204:
        return "reponse : 204 ", 201
    else:
        return f"❌ Erreur: {response.status_code}<br>{response.text}", response.status_code

if __name__ == "__main__":
    app.run(debug=True)
