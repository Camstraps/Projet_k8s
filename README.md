# Projet_k8s
minikube tunnel

# k9s
curl -sS https://webinstall.dev/k9s | bash
source ~/.config/envman/PATH.env

# traefik
#### chart helm traefik
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik --namespace=traefik -f traefik/value.yaml
helm upgrade traefik traefik/traefik --namespace traefik -f traefik/value.yaml
#### Certificat
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes -keyout leo.local.key -out leo.local.crt -subj "/CN=*.leo.local" -addext "subjectAltName=DNS:*.leo.local"
kubectl create secret tls default-certificate --cert=leo.local.crt --key=leo.local.key --namespace=traefik
#### ingressroute & TLSOptions
kubectl apply -f tlsstore.yaml
kubectl apply -f traefik/ingress_traefik.yaml
minikube tunnel

# prometheus
helm install prometheus prometheus-community/kube-prometheus-stack --version 69.2.2 --namespace monitoring


Outils :
- Kubernetes
- Prometheus
- Les application du proff 5 appli