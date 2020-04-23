# Plex Docker Image for Raspberry Pi [![Build Status](https://travis-ci.org/nelsonyaccuzzi/docker-rpi-plex.svg?branch=master)](https://travis-ci.org/nelsonyaccuzzi/docker-rpi-plex)

## Usage

```
docker run -d \
  --name plex \
  -v /path/to/config:/config \
  -v /path/to/data:/data \
  --net host \
  --restart unless-stopped \
  nelsonyaccuzzi/docker-rpi-plex
```
