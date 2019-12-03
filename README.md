# VLC Server Docker image

## Build and run as

```bash
docker build -t vlc-server .
docker run -d --rm -p 8080:8080 -v `$(pwd)`/media/:/opt/vlc-media --name vlc_server vlc-server
```
