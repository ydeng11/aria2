# Building and pushing the aria2 Docker image (PR #2222 fix)

This image is built from the **local** source tree with the invalid-range-header retry fix (PR #2222). Suitable for Synology (amd64) and other Linux hosts.

## Build

From the repository root:

```bash
docker build -t ydeng11/aria2:invalid-range-retry .
```

## Push to Docker Hub

1. Log in (if not already):

   ```bash
   docker login
   ```

2. Push the image:

   ```bash
   docker push ydeng11/aria2:invalid-range-retry
   ```

## Use on Synology

In Container Manager (or Docker on Synology), use image:

- `ydeng11/aria2:invalid-range-retry`

Example run (customize as needed):

```bash
docker run --rm -v /path/to/downloads:/downloads ydeng11/aria2:invalid-range-retry \
  -d /downloads \
  --enable-rpc \
  --rpc-listen-all \
  --rpc-allow-origin-all
```
