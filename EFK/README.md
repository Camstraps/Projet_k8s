helm upgrade --install elasticsearch bitnami/elasticsearch -f EFK/elasticsearch_values.yaml -n monitoring
helm upgrade --install kibana bitnami/kibana -f EFK/kibana_values.yaml -n monitoring
kubectl apply -f EFK/ingressroute.yaml

helm repo add elastic https://helm.elastic.co
helm upgrade --install filebeat elastic/filebeat -f EFK/filebeat_values.yaml -n monitoring