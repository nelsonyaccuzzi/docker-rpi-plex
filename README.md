# Plex Docker Image for Raspberry Pi 
![Travis (.org)](https://img.shields.io/travis/nelsonyaccuzzi/docker-rpi-plex?style=flat-square)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/nelsonyaccuzzi/docker-rpi-plex?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/nelsonyaccuzzi/docker-rpi-plex?style=flat-square)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/nelsonyaccuzzi/docker-rpi-plex?sort=semver&style=flat-square)

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
