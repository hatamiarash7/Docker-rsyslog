# Docker rsyslog

[![GitHub license](https://img.shields.io/github/license/hatamiarash7/docker-rsyslog)](https://github.com/hatamiarash7/docker-rsyslog/blob/master/LICENSE) [![Release](https://github.com/hatamiarash7/Docker-rsyslog/actions/workflows/docker.yml/badge.svg)](https://github.com/hatamiarash7/Docker-rsyslog/actions/workflows/docker.yml) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/hatamiarash7/rsyslog)

Deploy an rsyslog server using Docker.

## Image details

- Base image: `alpine:3.24.2`
- Installed packages: `rsyslog`, `bash`
- Exposed port: `514` (UDP syslog)
- Default command: `rsyslogd -n`

## Quick start

```bash
docker run -d \
  --name rsyslog \
  -p 514:514/udp \
  hatamiarash7/rsyslog:v1.1.0
```

## Configuration

The container ships with `/etc/rsyslog.conf`:

```conf
$ModLoad imudp.so

$template SimpleFormat,"%msg%\n"

*.* /proc/self/fd/2;SimpleFormat

$MaxMessageSize 20k

$UDPServerRun 514
```

### Default behavior

- Listens for syslog messages on UDP `514`
- Writes received messages to container `stderr` (Docker logs)
- Accepts message size up to `20k`

### Use your own rsyslog config

```bash
docker run -d \
  --name rsyslog \
  -p 514:514/udp \
  -v $(pwd)/rsyslog.conf:/etc/rsyslog.conf:ro \
  hatamiarash7/rsyslog:v1.1.0
```

## Usage examples

### Enable debug in entrypoint

```bash
docker run -d \
  --name rsyslog \
  -e DEBUG=1 \
  -p 514:514/udp \
  hatamiarash7/rsyslog:v1.1.0
```

### Persist logs to a host file with custom config

Create `rsyslog-file.conf`:

```conf
$ModLoad imudp.so
$UDPServerRun 514

*.* /var/log/remote.log
```

Run the container:

```bash
docker run -d \
  --name rsyslog \
  -p 514:514/udp \
  -v $(pwd)/rsyslog-file.conf:/etc/rsyslog.conf:ro \
  -v $(pwd)/logs:/var/log \
  hatamiarash7/rsyslog:v1.1.0
```

### Docker Compose

```yaml
services:
  rsyslog:
    image: hatamiarash7/rsyslog:v1.1.0
    container_name: rsyslog
    ports:
      - "514:514/udp"
    restart: unless-stopped
```

---

## Support 💛

[![Donate with Bitcoin](https://img.shields.io/badge/Bitcoin-bc1qmmh6vt366yzjt3grjxjjqynrrxs3frun8gnxrz-orange)](https://donatebadges.ir/donate/Bitcoin/bc1qmmh6vt366yzjt3grjxjjqynrrxs3frun8gnxrz) [![Donate with Ethereum](https://img.shields.io/badge/Ethereum-0x0831bD72Ea8904B38Be9D6185Da2f930d6078094-blueviolet)](https://donatebadges.ir/donate/Ethereum/0x0831bD72Ea8904B38Be9D6185Da2f930d6078094)

<div><a href="https://payping.ir/@hatamiarash7"><img src="https://cdn.payping.ir/statics/Payping-logo/Trust/blue.svg" height="128" width="128"></a></div>

## Contributing 🤝

Don't be shy and reach out to us if you want to contribute 😉

1. Fork it !
2. Create your feature branch : `git checkout -b my-new-feature`
3. Commit your changes : `git commit -am 'Add some feature'`
4. Push to the branch : `git push origin my-new-feature`
5. Submit a pull request

## Issues

Each project may have many problems. Contributing to the better development of this project by reporting them. 👍
