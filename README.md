# Projet_k8s

# k9s
curl -sS https://webinstall.dev/k9s | bash
source ~/.config/envman/PATH.env

# traefik
#### chart helm traefik
helm install traefik traefik/traefik --namespace=traefik -f value.yaml
helm upgrade traefik traefik/traefik --namespace traefik -f values.yaml
#### Certificat
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes -keyout traefikleo.local.key -out traefikleo.local.crt -subj "/CN=traefikleo.local" -addext "subjectAltName=DNS:traefikleo.local"
kubectl create secret tls traefikleo-local-cert --cert=traefikleo.local.crt --key=traefikleo.local.key --namespace=traefik
#### ingressroute & TLSOptions
kubectl apply -f .\traefik\ingress_traefik.yaml

# prometheus
helm install prometheus prometheus-community/kube-prometheus-stack --version 69.2.2 --namespace monitoring


Outils :
- Kubernetes
- Prometheus
- Les application du proff 5 appli