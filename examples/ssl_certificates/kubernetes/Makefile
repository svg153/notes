h:=helm
ha:=$(h) repo add
hi:=$(h) install
hu:=$(h) uninstall

run: prom blackbox grafana


prom-repo:
	-$(ha) prometheus-community https://prometheus-community.github.io/helm-charts
prom: prom-repo
	-$(hi) prometheus prometheus-community/prometheus --values prometheus.yaml
# export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
# kubectl --namespace default port-forward $POD_NAME 9090
# export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus-pushgateway,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
# kubectl --namespace default port-forward ${POD_NAME} 9091
# export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=" -o jsonpath="{.items[0].metadata.name}")
# kubectl --namespace default port-forward $POD_NAME 9093
blackbox: prom-repo
	-$(hi) blackbox-exporter prometheus-community/prometheus-blackbox-exporter --values blackbox.yaml
# export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=prometheus-blackbox-exporter,app.kubernetes.io/instance=blackbox-exporter" -o jsonpath="{.items[0].metadata.name}")
# export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
# echo "Visit http://127.0.0.1:8080 to use your application"
# kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT

grafana-repo:
	-$(ha) grafana-charts https://grafana.github.io/helm-charts
grafana: grafana-repo
	-$(hi) grafana grafana-charts/grafana
# export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
# kubectl --namespace default port-forward ${POD_NAME} 3000

remove:
	-$(hu) prometheus
	-$(hu) blackbox-exporter
	-$(hu) grafana
