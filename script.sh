#!/bin/bash

# Script pour les opérations EC2
# Ce script sera uploadé vers S3

echo "=== Script EC2 Management ==="
echo "Date d'exécution: $(date)"

# Fonction pour lister les instances EC2
list_instances() {
    echo "Liste des instances EC2:"
    aws ec2 describe-instances \
        --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress]' \
        --output table
}

# Fonction pour arrêter une instance
stop_instance() {
    local instance_id=$1
    if [ -z "$instance_id" ]; then
        echo "Usage: stop_instance <instance-id>"
        return 1
    fi
    
    echo "Arrêt de l'instance: $instance_id"
    aws ec2 stop-instances --instance-ids "$instance_id"
}

# Fonction pour démarrer une instance
start_instance() {
    local instance_id=$1
    if [ -z "$instance_id" ]; then
        echo "Usage: start_instance <instance-id>"
        return 1
    fi
    
    echo "Démarrage de l'instance: $instance_id"
    aws ec2 start-instances --instance-ids "$instance_id"
}

# Menu interactif
echo "Choisissez une action:"
echo "1. Lister les instances"
echo "2. Arrêter une instance"
echo "3. Démarrer une instance"
read -p "Entrez votre choix (1-3): " choice

case $choice in
    1)
        list_instances
        ;;
    2)
        read -p "Entrez l'ID de l'instance à arrêter: " instance_id
        stop_instance "$instance_id"
        ;;
    3)
        read -p "Entrez l'ID de l'instance à démarrer: " instance_id
        start_instance "$instance_id"
        ;;
    *)
        echo "Choix invalide"
        exit 1
        ;;
esac

echo "Script terminé."