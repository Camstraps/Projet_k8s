#!/bin/bash

# Fonction pour vérifier l'état de RabbitMQ
wait_for_rabbitmq() {
  until rabbitmqctl status &>/dev/null; do
    echo "En attente de RabbitMQ..."
    sleep 5
  done
}

# Attendre que RabbitMQ soit prêt
wait_for_rabbitmq

# Ajouter l'utilisateur et définir les permissions
rabbitmqctl add_user root Btssio75000
rabbitmqctl set_permissions -p / root ".*" ".*" ".*"

echo "Utilisateur root ajouté avec succès à RabbitMQ."
