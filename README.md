# Projet_k8s

# k9s
curl -sS https://webinstall.dev/k9s | bash
source ~/.config/envman/PATH.env

# A chaque fois
#### Tunnel
minikube tunnel
#### Certificat
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes -keyout leo.local.key -out leo.local.crt -subj "/CN=*.leo.local" -addext "subjectAltName=DNS:*.leo.local"
kubectl create secret tls traefik --cert=leo.local.crt --key=leo.local.key --namespace=traefik
# traefik
#### chart helm traefik
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik --namespace=traefik -f traefik/value.yaml
helm upgrade traefik traefik/traefik --namespace traefik -f traefik/value.yaml
#### ingressroute & TLSOptions
kubectl apply -f traefik/ingress_traefik.yaml

# prometheus
helm install prometheus prometheus-community/kube-prometheus-stack --version 69.2.2 --namespace monitoring


# Service
#### Chart Helm
helm install micro-service ./helm-kube --namespace ynov

Il faut modifier le fichier appseting.json dans web



Outils :
- Kubernetes
- Prometheus
- Les application du proff 5 appli