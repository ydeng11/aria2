# Building and pushing the aria2 Docker image (PR #2222 fix)

This image is built from the **local** source tree with the invalid-range-header retry fix (PR #2222). Suitable for Synology (amd64) and other Linux hosts.

## Build via CI (recommended)

A GitHub Actions workflow (`.github/workflows/docker.yml`) builds and pushes the image
on push to `master`. It runs natively on `ubuntu-latest` (no emulation slowdown).

### One-time setup

Add these secrets to the GitHub repo (`Settings → Secrets and variables → Actions`):

| Secret | Value |
|---|---|
| `DOCKERHUB_USERNAME` | `ydeng11` |
| `DOCKERHUB_TOKEN` | Docker Hub access token ([generate one](https://hub.docker.com/settings/security)) |

Then push to `master` — the image builds and pushes automatically.

## Build locally (slow on Apple Silicon)

From the repository root:

```bash
docker build --platform linux/amd64 -t ydeng11/aria2:invalid-range-retry .
```

⚠️ On Apple Silicon (ARM64) this runs under QEMU emulation and takes 15–30+ minutes.

## Push to Docker Hub

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
