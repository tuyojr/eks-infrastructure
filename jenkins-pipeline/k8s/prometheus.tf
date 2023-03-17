locals {
    prometheus_config = <<CONFIG
        global:
            # How frequently to scrape targets by default.
            scrape_interval: 1m
            # How long until a scrape request times out.
            scrape_timeout: 10s
            # How frequently to evaluate rules.
            evaluation_interval: 1m

        rule_files:
            - "/etc/prometheus/alert.rules"

        alerting:
            alertmanagers:
            - static_configs:
              - targets:
                - alertmanager:9093

        scrape_configs:
            - job_name: "frontend"
              scrape_interval: 5s
              metrics_path: 'metrics'
              static_configs:
                - targets: ['edge-router']

            # The job name assigned to scraped metrics by default.
            - job_name: "catalogue"
              # How frequently to scrape targets from this job.
              scrape_interval: 5s
              # List of labeled statically configured targets for this job.
              static_configs:
              # The targets specified by the static config.
                - targets: ['catalogue']

            - job_name: "payment"
              scrape_interval: 5s
              static_configs:
                - targets: ['payment']

            - job_name: "user"
              scrape_interval: 5s
              static_configs:
                - targets: ['user']

            - job_name: "orders"
              scrape_interval: 5s
              # The HTTP resource path on which to fetch metrics from targets.
              metrics_path: 'metrics'
              static_configs:
                - targets: ['orders']

            - job_name: "cart"
              scrape_interval: 5s
              metrics_path: 'metrics'
              static_configs:
                - targets: ['carts']

            - job_name: "shipping"
              scrape_interval: 5s
              metrics_path: 'metrics'
              static_configs:
                - targets: ['shipping']

            - job_name: "queue-master"
              scrape_interval: 5s
              metrics_path: 'prometheus'
              static_configs:
                - targets: ['queue-master']

            - job_name: 'node-exporter'
              scrape_interval: 5s
              metrics_path: 'metrics'
              static_configs:
                - targets: ['nodeexporter:9100']
    CONFIG
}

resource "kubernetes_config_map" "prometheus" {
    metadata {
        name = "prometheus-config"
        namespace = "monitoring"
    }

    data = {
        "prometheus.yml" = local.prometheus_config
    }
}