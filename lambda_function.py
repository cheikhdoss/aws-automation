import boto3
import json

def lambda_handler(event, context):
    """
    Fonction Lambda pour arrêter les instances EC2
    """
    ec2 = boto3.client('ec2')
    
    try:
        # Récupérer les instances EC2 en cours d'exécution
        response = ec2.describe_instances(
            Filters=[
                {
                    'Name': 'instance-state-name',
                    'Values': ['running']
                }
            ]
        )
        
        instance_ids = []
        for reservation in response['Reservations']:
            for instance in reservation['Instances']:
                instance_ids.append(instance['InstanceId'])
        
        if instance_ids:
            # Arrêter les instances
            ec2.stop_instances(InstanceIds=instance_ids)
            print(f"Instances arrêtées: {instance_ids}")
            
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'message': f'Instances arrêtées avec succès: {instance_ids}'
                })
            }
        else:
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'message': 'Aucune instance en cours d\'exécution trouvée'
                })
            }
            
    except Exception as e:
        print(f"Erreur: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e)
            })
        }