# Tinfoil Containers — Hello World

> **Moved:** The current source and build workflow are maintained in [tinfoilsh/examples](https://github.com/tinfoilsh/examples/tree/main/tinfoil-containers-hello-world). This repository remains available for existing links, historical measured releases, and existing image references. Do not replace deployment or attestation repository identities with the examples directory URL.

A minimal Docker image to play with [Tinfoil Containers](https://docs.tinfoil.sh/containers/overview): a tiny Go HTTP server, built and published from this repo. To deploy it inside a [secure enclave](https://docs.tinfoil.sh/containers/overview), use [`tinfoil-containers-template`](https://github.com/tinfoilsh/tinfoil-containers-template).

The server reads a `MESSAGE` env var and a `GREETING_TOKEN` secret, and responds on every path with:

```
MESSAGE: Hello from a Tinfoil Container!
GREETING_TOKEN: present
```

(`GREETING_TOKEN: absent` if the secret isn't set.)

## Build off of this

Follow the [current build-and-publish instructions](https://github.com/tinfoilsh/examples/tree/main/tinfoil-containers-hello-world#build-off-of-this) in the examples repository. The deployment configuration still lives in a separate [`tinfoil-containers-template`](https://github.com/tinfoilsh/tinfoil-containers-template) repository.

## What's Inside

- **`main.go`** — ~20-line `net/http` server, stdlib only
- **`Dockerfile`** — multi-stage `golang:1.26.2-alpine` → `scratch`, ~5 MB final image
- **`.github/workflows/tinfoil-release.yml`** — manual dispatch: builds, pushes to GHCR, tags, creates a GitHub release with the image digest
