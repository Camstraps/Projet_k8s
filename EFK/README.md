helm upgrade --install elasticsearch bitnami/elasticsearch -f elk-good/elasticsearch_values.yaml -n monitoring
helm upgrade --install kibana bitnami/kibana -f elk-good/kibana_values.yaml -n monitoring
kubectl apply -f elk-good/ingressroute.yaml
