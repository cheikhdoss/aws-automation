from flask import Flask, request, render_template
import requests

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("form.html")

@app.route("/trigger", methods=["POST"])
def trigger_pipeline():
    data = {
        "token": "glptt-07d692ddb0988fb55c45c232d0b5f498ba5de5ad",
        "ref": "main",
        "variables[INSTANCE_NAME]": request.form["instance_name"],
        "variables[INSTANCE_OS]": request.form["instance_os"],
        "variables[INSTANCE_SIZE]": request.form["instance_size"],
        "variables[INSTANCE_ENV]": request.form["instance_env"],
    }

    project_id = "78064655"
    url = f"https://gitlab.com/api/v4/projects/78064655/trigger/pipeline"
    response = requests.post(url, data=data)

    return f"Résultat: {response.status_code}<br>{response.text}"

if __name__ == "__main__":
    app.run(debug=True)
