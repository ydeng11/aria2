# Building and pushing the aria2 Docker image (PR #1869 fix)

This image is built from the **local** source tree with the EX_INVALID_RANGE_HEADER workaround (PR #1869) applied. Suitable for Synology (amd64) and other Linux hosts.

## Build

From the repository root:

```bash
docker build -t YOUR_DOCKERHUB_USER/aria2:ex-invalid-range-fix .
```

Replace `YOUR_DOCKERHUB_USER` with your Docker Hub username.

## Push to Docker Hub

1. Log in (if not already):

   ```bash
   docker login
   ```

2. Push the image:

   ```bash
   docker push YOUR_DOCKERHUB_USER/aria2:ex-invalid-range-fix
   ```

## Use on Synology

In Container Manager (or Docker on Synology), use image:

- `YOUR_DOCKERHUB_USER/aria2:ex-invalid-range-fix`

Example run (customize as needed):

```bash
docker run --rm -v /path/to/downloads:/downloads YOUR_DOCKERHUB_USER/aria2:ex-invalid-range-fix \
  -d /downloads \
  --enable-rpc \
  --rpc-listen-all \
  --rpc-allow-origin-all
```
