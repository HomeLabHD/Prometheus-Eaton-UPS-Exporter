# Prometheus Eaton UPS Exporter

A Prometheus exporter for Eaton UPS devices. Collects metrics from the REST API of Eaton UPS web interfaces including temperature, system info, input/output power, and battery status. Supports monitoring multiple UPSs with configurable timeouts.

<!-- sf:project:start -->
[![badge/GitHub-source-181717?logo=github](https://img.shields.io/badge/GitHub-source-181717?logo=github)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter) [![badge/GitLab-source-FC6D26?logo=gitlab](https://img.shields.io/badge/GitLab-source-FC6D26?logo=gitlab)](https://gitlab.prplanit.com/PrPlanIT/HomeLabHD/prometheus-eaton-ups-exporter) [![Last Commit](https://img.shields.io/github/last-commit/HomeLabHD/prometheus-eaton-ups-exporter)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/commits) [![Open Issues](https://img.shields.io/github/issues/HomeLabHD/prometheus-eaton-ups-exporter)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/issues) ![github/issues-pr/HomeLabHD/prometheus--eaton--ups--exporter](https://img.shields.io/github/issues-pr/HomeLabHD/prometheus--eaton--ups--exporter) [![Contributors](https://img.shields.io/github/contributors/HomeLabHD/prometheus-eaton-ups-exporter)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/graphs/contributors)
<!-- sf:project:end -->
<!-- sf:badges:start -->
[![build](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/build.svg)](https://gitlab.prplanit.com/PrPlanIT/HomeLabHD/prometheus-eaton-ups-exporter/-/pipelines) [![license](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/license.svg)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/blob/master/LICENSE) [![release](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/release.svg)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/releases) ![updated](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/updated.svg) [![badge/donate-FF5E5B?logo=ko-fi&logoColor=white](https://img.shields.io/badge/donate-FF5E5B?logo=ko-fi&logoColor=white)](https://ko-fi.com/T6T41IT163) [![badge/sponsor-EA4AAA?logo=githubsponsors&logoColor=white](https://img.shields.io/badge/sponsor-EA4AAA?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/HomeLabHD)
<!-- sf:badges:end -->
<!-- sf:image:start -->
[![badge/Docker-hlhd%2Fprometheus--eaton--ups--exporter-2496ED?logo=docker&logoColor=white](https://img.shields.io/badge/Docker-hlhd%2Fprometheus--eaton--ups--exporter-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/hlhd/prometheus-eaton-ups-exporter) [![pulls](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/pulls.svg)](https://hub.docker.com/r/hlhd/prometheus-eaton-ups-exporter)

[![latest](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/latest.svg)](https://hub.docker.com/r/hlhd/prometheus-eaton-ups-exporter/tags?name=latest) ![updated](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/release-updated.svg) [![size](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/release-size.svg)](https://hub.docker.com/r/hlhd/prometheus-eaton-ups-exporter/tags?name=v0.9.3) [![latest-dev](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/latest-dev.svg)](https://hub.docker.com/r/hlhd/prometheus-eaton-ups-exporter/tags?name=latest-dev) ![updated](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/dev-updated.svg) [![size](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/badges/dev-size.svg)](https://hub.docker.com/r/hlhd/prometheus-eaton-ups-exporter/tags?name=latest-dev)
<!-- sf:image:end -->

### Features:

|                                |                                                                                           |
| ------------------------------ | ----------------------------------------------------------------------------------------- |
| **Extended Metrics**           | Temperature, system info (firmware versions), input/output health, energy tracking, efficiency |
| **Multi-UPS Monitoring**       | Monitor multiple Eaton UPSs from a single exporter instance                               |
| **Configurable Timeouts**      | `--request-timeout` and `--login-timeout` CLI flags for slow management cards              |
| **Threading Support**          | Optional multi-threaded scraping for faster collection across multiple UPSs                |
| **Grafana Dashboard**          | Included dashboard for out-of-the-box visualization                                       |
| **Self-Signed SSL Support**    | `-k` flag for UPSs with self-signed certificates                                         |

### Metrics Exported:

| Category | Metrics |
|----------|---------|
| **System** | Device name, bootloader version, firmware version |
| **Temperature** | Internal UPS temperature (Celsius) |
| **Input** | Voltage, frequency, current, voltage min/max/nominal, health status |
| **Output** | Voltage, frequency, current, apparent power (VA), active power (W), power factor, load ratio, average energy, cumulated energy, efficiency, health status |
| **Battery** | Voltage, state of charge (%), remaining time (s), health status |

### Supported Devices:

- Eaton 5P Series (recent firmwares)
- Eaton 5PX Series (firmware 3.1.8+)

## Quick Start

```bash
docker run -d -p 9795:9795 \
  -v ./config.json:/usr/src/app/etc/config.json:ro \
  hlhd/prometheus-eaton-ups-exporter:latest
```

### Configuration

Create a `config.json` with your UPS credentials:

```json
{
  "MyUPS": {
    "address": "https://10.0.0.1",
    "user": "admin",
    "password": "secret"
  }
}
```

### Usage

```
prometheus_eaton_ups_exporter.py [-h] -c CONFIG [-w HOST:PORT] [-k] [-t] [-v]
                                 [--login-timeout SECONDS] [--request-timeout SECONDS]

  -c, --config CONFIG         JSON config file with UPS addresses and credentials
  -w, --web.listen-address    Listen address (default: 0.0.0.0:9795)
  -k, --insecure              Allow self-signed SSL certificates
  -t, --threading             Multi-threaded scraping (faster for multiple UPSs)
  -v, --verbose               Verbose logging
  --login-timeout             Login timeout in seconds (default: 3, range: 2-30)
  --request-timeout           API request timeout in seconds (default: 10, range: 2-30)
```

### Defaults

| Setting | Default |
|---------|---------|
| Listen address | `0.0.0.0:9795` |
| Login timeout | 3 seconds |
| Request timeout | 10 seconds |

### Kubernetes

The exporter is deployed via a Deployment with the config mounted from a Secret:

```yaml
containers:
  - name: exporter
    image: hlhd/prometheus-eaton-ups-exporter:latest
    ports:
      - containerPort: 9795
    volumeMounts:
      - name: config
        mountPath: /usr/src/app/etc/config.json
        subPath: config.json
        readOnly: true
```

### Grafana Dashboard

An included [Grafana dashboard](docs/grafana-dashboard.json) provides out-of-the-box visualization of all exported metrics.

---

## Image Contents

<!-- sf:contents-base:start -->
![python](https://img.shields.io/badge/python-3.14.3-0078D4?style=flat)
<!-- sf:contents-base:end -->

<!-- sf:contents-apk:start -->
*No items*
<!-- sf:contents-apk:end -->

<!-- sf:contents-pip:start -->
![requirements.txt](https://img.shields.io/badge/requirements.txt-555?style=flat)
<!-- sf:contents-pip:end -->

## Credits

- [psyinfra](https://github.com/psyinfra/prometheus-eaton-ups-exporter) — original exporter
- [nvollmar](https://github.com/nvollmar/prometheus-eaton-ups-exporter) — temperature, system info, extended metrics, Grafana dashboard
- [adyekjaer](https://github.com/adyekjaer/prometheus-eaton-ups-exporter) — firmware 3.1.8 compatibility

## License

Distributed under the [ISC](LICENSE) License.
