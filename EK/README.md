helm upgrade --install elasticsearch bitnami/elasticsearch -f EK/elasticsearch_values.yaml -n monitoring
helm upgrade --install kibana bitnami/kibana -f EK/kibana_values.yaml -n monitoring
kubectl apply -f EK/ingressroute.yaml

helm repo add elastic https://helm.elastic.co
helm upgrade --install filebeat elastic/filebeat -f EK/filebeat_values.yaml -n monitoring