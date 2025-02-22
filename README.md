# Projet_k8s
### Prérequis
 - [Minikube](#)                   :white_check_mark:
 - [Traefik](#Traefik)             :white_check_mark:
 - [Certificat](#Certificat)       :white_check_mark:
 - [Micro-Service](#Micro-Service) :white_check_mark:
 - [Prometheus](#Prometheus)       :x:
 - [ELK](#ELK)                     :x:
 - [Outils-k9s](#Outils-k9s)       :white_check_mark:

# Minikube
### Start
```bash
minikube start
```
### Tunnel
Expose L'ip des pods sur la machine Hote
```bash 
minikube tunnel
```
# Traefik
### Installation
Ajoute repo helm treafik:
```bash
helm repo add traefik https://traefik.github.io/charts
```
Update des repo 
```bash
helm repo update
```
Installation de treafik a partir de sa charte helm
```bash
helm install traefik traefik/traefik --namespace traefik -f traefik/value.yaml
```
Upgrade treafik helm
```bash
helm upgrade traefik traefik/traefik --namespace traefik -f traefik/value.yaml
```
### IngressRoute
Application de l'ingress route pour treafik
```bash
kubectl apply -f traefik/ingress_traefik.yaml
```
# Certificat
### SSL
Création d'un certificat avec OpenSSL pour tout les sous-domaine ``` *.leo.local ```
``` bash
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes -keyout leo.local.key -out leo.local.crt -subj "/CN=*.leo.local" -addext "subjectAltName=DNS:*.leo.local"
```
```bash
kubectl create secret tls traefik --cert=leo.local.crt --key=leo.local.key --namespace=xxxx
```
# Micro-Service
### Helm
Commande a exécuté a la racine de Projet_k8s
```bash
helm install micro-service ./helm-kube --namespace ynov
```
Il faut modifier le fichier appseting.json dans web pour généré une bonne image
# Prometheus
### Install
```bash
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack --version 69.4.1 -n monitoring -f prometheus_value.yaml
```
```bash
helm upgrade --install metrics-server bitnami/metrics-server -n monitoring -f metrics_server_value.yaml
```
```bash
kubectl apply -f ingressroute.yaml
```
### 🚦 les métriques de l'état du cluster:
| Objectif                          | Requête PromQL                                 | Explication |
|------------------------------------|-----------------------------------------------|-------------|
| Nombre total de nœuds             | `kube_node_info`                        | Affiche le nombre total de nœuds dans le cluster. | :white_check_mark:
| Nombre de nœuds Ready             | `kube_node_status_condition{condition="Ready",status="true"}` | Compte les nœuds qui sont **Ready**. | :white_check_mark:
| Nombre de nœuds NotReady          | `kube_node_status_condition{condition="Ready",status="false"}` | Compte les nœuds **non disponibles**. | :white_check_mark:
| État des pods (Running, Pending)  | `kube_pod_status_phase{namespace="ynov"}`                        | Affiche le nombre de pods dans chaque état. | :white_check_mark:


### 📡 Ressources des Nœuds et des Pods

| Objectif                          | Requête PromQL                                 | Explication |
|------------------------------------|-----------------------------------------------|-------------|
| Utilisation CPU des nœuds         | `sum(rate(node_cpu_seconds_total[5m])) by (instance)` | Affiche la consommation CPU de chaque nœud. |
| Utilisation mémoire des nœuds     | `node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100` | Pourcentage de mémoire disponible. |
| Utilisation CPU des pods          | `sum(rate(container_cpu_usage_seconds_total[5m])) by (pod)` | Consommation CPU par pod. |
| Utilisation mémoire des pods      | `sum(container_memory_usage_bytes) by (pod) / 1073741824`  | Consommation mémoire par pod. | :white_check_mark:
| Charge du kube-apiserver          | `rate(apiserver_request_total[5m])`           | Nombre de requêtes envoyées à l’API Kubernetes. |
| État des composants du cluster    | `up`                                          | Vérifie si les composants sont UP ou DOWN. |



Pour voir les metrics cpu ou ram des namespace:
container_cpu_usage_seconds_total{namespace="ynov"}
container_memory_usage_bytes{namespace="ynov"}


# ELK To-Do
# Outils-k9s
### k9s
Outils CLI Pour la gestions de k8s
Installation: Ubuntu/Deb
```bash
curl -sS https://webinstall.dev/k9s | bash
source ~/.config/envman/PATH.env
```
