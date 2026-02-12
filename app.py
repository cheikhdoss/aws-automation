from flask import Flask, request, render_template
import requests
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("form.html")

@app.route("/trigger", methods=["POST"])
def trigger_pipeline():
    github_token = os.getenv("GITHUB_TOKEN")
    owner = "cheikhdoss"
    repo = "aws-automation"
    workflow_file = "terraform.yml"
    
    url = f"https://api.github.com/repos/{owner}/{repo}/actions/workflows/{workflow_file}/dispatches"
    
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {github_token}",
        "X-GitHub-Api-Version": "2022-11-28"
    }
    
    bucket_name = request.form.get("bucket_name", "m2-cloud-logs--name")

    data = {
        "ref": "main",
        "inputs": {
            "bucket_name": bucket_name
        }
    }
    
    response = requests.post(url, json=data, headers=headers)

    if response.status_code == 204:
        return "✅ Pipeline AWS déclenché avec succès !", 200
    else:
        return f"❌ Erreur: {response.status_code}<br>{response.text}", response.status_code

if __name__ == "__main__":
    app.run(debug=True)
