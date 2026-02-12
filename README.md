# AWS CI/CD Pipeline avec GitHub Actions

Ce projet implémente un pipeline CI/CD avec GitHub Actions pour automatiser le déploiement AWS selon les spécifications suivantes :

## 🎯 Fonctionnalités

### Pipeline en 3 étapes :
1. **Validate** : Validation des credentials AWS
2. **Deploy** : Déploiement de la fonction Lambda `stop-ec2`
3. **Upload** : Upload du script EC2 vers S3

## 📁 Structure du projet

```
├── .github/workflows/terraform.yml  # Pipeline GitHub Actions
├── lambda_function.py               # Fonction Lambda pour arrêter les instances EC2
├── script.sh                        # Script EC2 à uploader vers S3
├── app.py                          # Application Flask pour déclencher le pipeline
├── templates/form.html             # Interface web
└── README.md                       # Ce fichier
```

## ⚙️ Configuration requise

### 1. Secrets GitHub
Configurez ces secrets dans votre repository GitHub (Settings > Secrets and variables > Actions) :

- `AWS_ACCESS_KEY` : Votre clé d'accès AWS IAM
- `AWS_SECRET_KEY` : Votre clé secrète AWS IAM
- `GITHUB_TOKEN` : Token GitHub pour déclencher le workflow

### 2. Variables d'environnement
Créez un fichier `.env` avec :
```
GITHUB_TOKEN=votre_token_github
```

### 3. Fonction Lambda
Assurez-vous qu'une fonction Lambda nommée `stop-ec2` existe dans votre compte AWS.

## 🚀 Utilisation

### Via l'interface web :
1. Lancez l'application Flask : `python app.py`
2. Ouvrez http://localhost:5000
3. Entrez le nom du bucket S3
4. Cliquez sur "Déclencher le Pipeline"

### Via GitHub Actions :
1. Allez dans l'onglet "Actions" de votre repository
2. Sélectionnez le workflow "AWS CI/CD Pipeline"
3. Cliquez sur "Run workflow"
4. Entrez le nom du bucket S3

## 📋 Détails du Pipeline

### Stage 1: Validate
- Utilise l'image Docker `amazon/aws-cli`
- Configure les credentials AWS
- Vérifie l'identité avec `aws sts get-caller-identity`

### Stage 2: Deploy
- Package la fonction Lambda en ZIP
- Met à jour le code de la fonction `stop-ec2`
- Utilise `aws lambda update-function-code`

### Stage 3: Upload
- Upload le script `script.sh` vers le bucket S3 spécifié
- Utilise `aws s3 cp`

## 🔧 IAM Permissions Required

Votre utilisateur IAM doit avoir les permissions suivantes :
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:GetCallerIdentity",
                "lambda:UpdateFunctionCode",
                "s3:PutObject"
            ],
            "Resource": "*"
        }
    ]
}
```

## 📝 Fonction Lambda

La fonction `lambda_function.py` :
- Liste toutes les instances EC2 en cours d'exécution
- Les arrête automatiquement
- Retourne un rapport de l'opération

## 📄 Script EC2

Le script `script.sh` fournit un menu interactif pour :
- Lister les instances EC2
- Arrêter une instance spécifique
- Démarrer une instance spécifique

## 🔍 Monitoring

Le pipeline affichera les logs en temps réel dans GitHub Actions, permettant de suivre :
- La validation des credentials
- Le statut du déploiement Lambda
- La confirmation de l'upload S3