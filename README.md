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
#### SSL
Création d'un certificat avec OpenSSL pour tout les sous-domaine ``` *.leo.local ```
``` bash
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes -keyout leo.local.key -out leo.local.crt -subj "/CN=*.leo.local" -addext "subjectAltName=DNS:*.leo.local"
```
```bash
kubectl create secret tls traefik --cert=leo.local.crt --key=leo.local.key --namespace=xxxx
```
# Micro-Service
#### Helm
Commande a exécuté a la racine de Projet_k8s
```bash
helm install micro-service ./helm-kube --namespace ynov
```
Il faut modifier le fichier appseting.json dans web pour généré une bonne image
# Prometheus To-Do
#### Install
helm install prometheus prometheus-community/kube-prometheus-stack --version 69.2.2 --namespace monitoring
# ELK To-Do
# Outils-k9s
### k9s
Outils CLI Pour la gestions de k8s
Installation: Ubuntu/Deb
```bash
curl -sS https://webinstall.dev/k9s | bash
source ~/.config/envman/PATH.env
```
