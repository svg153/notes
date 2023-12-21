docker:=docker run -it -d --rm

run: prom blackbox grafana

prom:
	-$(docker) --name prometheus -p 9090:9090 -v $$(pwd)/prometheus/config/:/etc/prometheus/ prom/prometheus --config.file=/etc/prometheus/prometheus.yml

blackbox:
	-$(docker) --name blackbox-exporter -p 9115:9115 -v $$(pwd)/blackbox-exporter/config/:/config blackbox-exporter --config.file=/config/config.yml

grafana:
	-$(docker) --name grafana -p 3000:3000 grafana/grafana