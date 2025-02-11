# Projet_k8s

# k9s

# traefik
#### chart helm traefik
helm install traefik traefik/traefik --namespace=traefik -f value.yaml
helm upgrade traefik traefik/traefik --namespace traefik -f values.yaml

#### Certificat
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes -keyout traefikleo.local.key -out traefikleo.local.crt -subj "/CN=traefikleo.local" -addext "subjectAltName=DNS:traefikleo.local"
kubectl create secret tls my-tls-secret --cert=traefikleo.local.crt --key=traefikleo.local.key --namespace=kube-system
#### ingressroute & TLSOptions
kubectl apply -f .\traefik\ingress_traefik.yaml

Outils :
- Kubernetes
- Prometheus
- Les application du proff 5 appli