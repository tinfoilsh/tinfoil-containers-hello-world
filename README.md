# Tinfoil Containers — Hello World

A standalone [Tinfoil Containers](https://docs.tinfoil.sh/containers/overview) example: a tiny Go HTTP server, a digest-pinned image, and a measured enclave configuration.

The server reads a `MESSAGE` env var and a `GREETING_TOKEN` secret, and responds on every path with:

```
MESSAGE: Hello from Tinfoil
GREETING_TOKEN: present
```

(`GREETING_TOKEN: absent` if the secret isn't set.)

## Deploy

1. Create a public repository with **[Use this template](https://github.com/tinfoilsh/tinfoil-containers-hello-world/generate)**. The supplied `tinfoil-config.yml` uses CVM 0.14.12 and a published image; no image build is needed.
2. Run **Tinfoil Release** with an unused version in your repository:
   ```bash
   gh workflow run tinfoil-release.yml -f version=v0.0.1
   ```
3. Wait for both release workflows to succeed and publish `tinfoil-deployment.json` and `tinfoil.hash` on that release.
4. Create a disposable `GREETING_TOKEN` secret, deploy your repository and tag, and make a tag-pinned verified request using **CLI v0.19.0 or later**. Follow the [quickstart](https://docs.tinfoil.sh/containers/quickstart#4-add-the-demo-secret) for these steps.

## Change the application

Edit `main.go`, then run **Build Image** (`build-image.yml`) with an image version.
Copy the digest from the workflow summary into `tinfoil-config.yml`, commit it,
and run **Tinfoil Release** with a new release version. Building an image alone
does not publish a deployable enclave release.

## What's Inside

- **`main.go`** — ~20-line `net/http` server, stdlib only
- **`Dockerfile`** — multi-stage `golang:1.26.2-alpine` → `scratch`, ~5 MB final image
- **`tinfoil-config.yml`** — guest version, image digest, environment, secret names, and routing
- **`.github/workflows/build-image.yml`** — builds and pushes the application image
- **`.github/workflows/tinfoil-release.yml`** and **`tinfoil-release-publish.yml`** — tag, measure, attest, and publish the enclave release
