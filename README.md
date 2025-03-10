# Projet_k8s
### Prérequis
  - [Minikube](#Minikube)             :white_check_mark:
  - [Traefik](#Traefik)               :white_check_mark:
  - [Certificat](#Certificat)         :white_check_mark:
  - [Micro-Service](#Micro-Service)   :white_check_mark:
    - [Helm](#helm) :white_check_mark:
  - [Prometheus](#Prometheus)         :white_check_mark:
    - [Install](#install) :white_check_mark:
    - [metrics](#metrics) :white_check_mark:
  - [ELK](#ELK)                       :white_check_mark:
    - [ElasticSearch](#elasticsearch) :white_check_mark:
    - [Kibana](#kibana) :white_check_mark:
    - [Filebeat](#filebeat) :white_check_mark:
  - [Outils](#Outils)         :white_check_mark:
    - [k9s](#k9s) :white_check_mark:

# Minikube
### Start
```bash
minikube start --cpus=8 --memory=16384 --disk-size=40g
```
### Tunnel
Expose L'ip des pods sur la machine Hote
```bash 
minikube tunnel
```
### Active metrics-server
```bash 
minikube addons enable metrics-server
```
### Creation des namespace
Ynov
```bash
k create namespace ynov
```
Monitoring
```bash
k create namespace monitoring
```
Traefik
```bash
k create namespace traefik
```
## Repo helm
Ajout de la chart bitnami utilisé dans la pluspart des charts présente ici
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
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
helm upgrade --install traefik traefik/traefik --namespace traefik -f traefik/value.yaml
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

Exécuter la commande 3 fois en remplaçant xxxx par le nom de chaque namespace
```bash
kubectl create secret tls traefik --cert=traefik/leo.local.crt --key=traefik/leo.local.key --namespace=xxxx
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
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack --version 69.4.1 -n monitoring -f prometheus/prometheus_value.yaml
```
```bash
kubectl apply -f prometheus/ingressroute.yaml
```
### Metrics
### 🚦 les métriques de l'état du cluster:
| Objectif                          | Requête PromQL                                 | Explication |
|------------------------------------|-----------------------------------------------|-------------|
| Nombre total de nœuds             | `kube_node_info`                        | Affiche le nombre total de nœuds dans le cluster. |
| Nombre de nœuds Ready             | `kube_node_status_condition{condition="Ready",status="true"}` | Compte les nœuds qui sont Ready. |
| Nombre de nœuds NotReady          | `kube_node_status_condition{condition="Ready",status="false"}` | Compte les nœuds non disponibles. |
| État des pods (Running, Pending)  | `kube_pod_status_phase{namespace="ynov"}`                        | Affiche le nombre de pods dans chaque état. |


### 📡 Ressources des Nœuds et des Pods

| Objectif                          | Requête PromQL                                 | Explication |
|------------------------------------|-----------------------------------------------|-------------|
| Utilisation CPU des nœuds %         | `100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) by (instance) * 100)` | Affiche la consommation CPU de chaque nœud. |
| DIsponible mémoire des nœuds     | `node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100` | Pourcentage de mémoire disponible. |
| Utilisation CPU des pods          | `sum(rate(container_cpu_usage_seconds_total[5m])) by (pod) * 1000` | Consommation CPU par pod. |
| Utilisation mémoire des pods      | `sum(container_memory_usage_bytes) by (pod) / 1073741824` | Consommation mémoire par pod. |
| État des composants du cluster    | `up`                                          | Vérifie si les composants sont UP ou DOWN. |

 - group by (job) (up)
 - up{job="kube-state-metrics"}
 - up{job="kube-proxy"}
 - up{job="apiserver"}
 - up{job="kubelet"}


# ELK
### ElasticSearch
Installation ElasticSearch dans monitoring
```bash
helm upgrade --install elasticsearch bitnami/elasticsearch -f EK/elasticsearch_values.yaml -n monitoring
```
### Kibana
Installation Kibana dans monitoring
```bash
helm upgrade --install elk-kibana bitnami/kibana --namespace monitoring -f kibana/values.yaml
```
Ingressroute
```bash
kubectl apply -f EK/ingressroute.yaml
```

### Filebeat
ajout du repo elastic
```bash
helm repo add elastic https://helm.elastic.co
```
Installation Filebeat dans monitoring
```bash
helm upgrade --install filebeat elastic/filebeat -f EK/filebeat_values.yaml -n monitoring
```
# Outils
### Lens

Installation arch:
```bash
git clone https://aur.archlinux.org/packages/lens-bin
cd lens-bin/
makepkg -si
```
### k9s
Outils CLI Pour la gestions de k8s

Installation: Arch
```bash
sudo pacman -S k9s
```
Installation: Ubuntu/Deb
```bash
curl -sS https://webinstall.dev/k9s | bash
source ~/.config/envman/PATH.env
```
