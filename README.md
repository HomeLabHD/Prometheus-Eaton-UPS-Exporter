# Prometheus Eaton UPS Exporter

A Prometheus exporter for Eaton UPS devices. Collects metrics from the REST API of Eaton UPS web interfaces including temperature, system info, input/output power, and battery status. Supports monitoring multiple UPSs with configurable timeouts.

<!-- sf:project:start -->
[![GitHub](https://img.shields.io/badge/GitHub-mirror-181717?logo=github)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter) [![GitLab](https://img.shields.io/badge/GitLab-source-FC6D26?logo=gitlab)](https://gitlab.prplanit.com/HomeLabHD/prometheus-eaton-ups-exporter) [![license](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/license.svg)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/blob/master/LICENSE) [![Open Issues](https://img.shields.io/github/issues/HomeLabHD/prometheus-eaton-ups-exporter)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/issues) [![Open PRs](https://img.shields.io/github/issues-pr/HomeLabHD/prometheus-eaton-ups-exporter)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/pulls) [![Contributors](https://img.shields.io/github/contributors/HomeLabHD/prometheus-eaton-ups-exporter)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/graphs/contributors) [![donate](https://img.shields.io/badge/donate-FF5E5B?logo=ko-fi&logoColor=white)](https://ko-fi.com/T6T41IT163) [![sponsor](https://img.shields.io/badge/sponsor-EA4AAA?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/HomeLabHD)
<!-- sf:project:end -->
<!-- sf:badges:start -->
[![release](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/release.svg)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/releases) [![build](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/build.svg)](https://gitlab.prplanit.com/HomeLabHD/prometheus-eaton-ups-exporter/-/pipelines) [![Last Commit](https://img.shields.io/github/last-commit/HomeLabHD/prometheus-eaton-ups-exporter)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/commits) [![StageFreight](https://img.shields.io/badge/StageFreight-0.9.2--dev+177b6a5-310937?logo=readthedocs&logoColor=white)](https://stagefreight.prplanit.com)
<!-- sf:badges:end -->
<!-- sf:image:start -->
[![GHCR](https://img.shields.io/badge/GHCR-prplanit%2Fprometheus--eaton--ups--exporter-181717?logo=github&logoColor=white)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/pkgs/container/prometheus-eaton-ups-exporter) [![Docker](https://img.shields.io/badge/Docker-prplanit%2Fprometheus--eaton--ups--exporter-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/prplanit/prometheus-eaton-ups-exporter) [![pulls](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/pulls.svg)](https://hub.docker.com/r/prplanit/prometheus-eaton-ups-exporter) [![Harbor](https://img.shields.io/badge/Harbor-prplanit%2Fprometheus--eaton--ups--exporter-60b932)](https://cr.pcfae.com/harbor/projects)

[![latest](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/release-latest.svg)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/pkgs/container/prometheus-eaton-ups-exporter) ![updated](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/release-updated.svg) [![size](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/release-size.svg)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/pkgs/container/prometheus-eaton-ups-exporter) [![latest-dev](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/dev-latest.svg)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/pkgs/container/prometheus-eaton-ups-exporter) ![updated](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/dev-updated.svg) [![size](https://raw.githubusercontent.com/HomeLabHD/prometheus-eaton-ups-exporter/master/.stagefreight/scribe/dev-size.svg)](https://github.com/HomeLabHD/prometheus-eaton-ups-exporter/pkgs/container/prometheus-eaton-ups-exporter)
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
[![python 3.14.7](https://img.shields.io/badge/python-3.14.7-0078D4?style=flat)](https://hub.docker.com/_/python)
<!-- sf:contents-base:end -->

<!-- sf:contents-apk:start -->
*No items*
<!-- sf:contents-apk:end -->

<!-- sf:contents-pip:start -->
[![requirements.txt](https://img.shields.io/badge/requirements.txt-555?style=flat)](https://pypi.org/project/requirements.txt/)
<!-- sf:contents-pip:end -->

## Credits

- [psyinfra](https://github.com/psyinfra/prometheus-eaton-ups-exporter) — original exporter
- [nvollmar](https://github.com/nvollmar/prometheus-eaton-ups-exporter) — temperature, system info, extended metrics, Grafana dashboard
- [adyekjaer](https://github.com/adyekjaer/prometheus-eaton-ups-exporter) — firmware 3.1.8 compatibility

## License

Distributed under the [ISC](LICENSE) License.
