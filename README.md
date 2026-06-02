# Tinfoil Containers — Hello World

A minimal example of a [Tinfoil Container](https://docs.tinfoil.sh/containers/overview) Image: a tiny Go HTTP server, built and published as a Docker image from this repo. Deployed in a [secure enclave](https://github.com/tinfoilsh/tinfoil-public-containers-template)

The server reads a `MESSAGE` environment variable and a `GREETING_TOKEN` secret, and responds on every path with:

```
MESSAGE: Hello from a Tinfoil Container!
GREETING_TOKEN: present
```

## Build off of this

1. Click **[Use this template](https://github.com/tinfoilsh/tinfoil-containers-hello-world/generate)** → **Create a new repository**
2. Release a version by running the **Tinfoil Release** workflow — this builds the image, pushes it to GHCR, updates `tinfoil-config.yml` with the new digest, and tags the release:
   - **CLI:** `gh workflow run tinfoil-release.yml -f version=v0.0.1`
   - **UI:** **Actions** tab → **Tinfoil Release** → **Run workflow**, then enter the version
3. In the [Tinfoil Dashboard](https://dash.tinfoil.sh), open the **Secrets** tab and add `GREETING_TOKEN` with any value
4. **Containers** → **Deploy**, select your repo and tag, and click **Deploy**

Once running, `curl https://<name>.<org>.containers.tinfoil.dev` returns the two-line response above. If you skip step 3, `GREETING_TOKEN` shows `absent` — confirming that secrets only reach the container when you wire them up.

## What's Inside

- **`main.go`** — ~20-line `net/http` server. No dependencies.
- **`Dockerfile`** — multi-stage `golang:1.23-alpine` → `scratch`, ~5 MB final image.
- **`tinfoil-config.yml`** — declares the image, the `MESSAGE` env var, and the `GREETING_TOKEN` secret. The image digest is a placeholder; the release workflow substitutes the real one.
- **`.github/workflows/`** — two-phase release:
  - `tinfoil-release.yml` (manual dispatch) builds the image, calls [`update-container-action`](https://github.com/tinfoilsh/update-container-action) to write the digest into the config, creates the tag, and dispatches phase 2
  - `tinfoil-release-publish.yml` (auto-triggered on the new tag) measures the image, signs the attestation, and publishes the GitHub release

Then click **Update** in the dashboard.

## Next Steps

- Want a config-only template (pre-built image, no Dockerfile)? See [`tinfoil-containers-template`](https://github.com/tinfoilsh/tinfoil-containers-template).
- See the [full documentation](https://docs.tinfoil.sh/containers/overview) for configuration options, debug mode, custom domains, and more.
