# Tinfoil Containers — Hello World

A minimal example of a [Tinfoil Container](https://docs.tinfoil.sh/containers/overview) deployment. Uses [hashicorp/http-echo](https://hub.docker.com/r/hashicorp/http-echo) — an HTTP server that responds with a fixed message — to demonstrate the full workflow.

## Deploy It

1. Fork this repo (or [create your own](https://github.com/tinfoilsh/tinfoil-containers-template) from the template)
2. Push a Git tag:
   ```bash
   git tag v0.0.1
   git push origin main --tags
   ```
3. Go to the [Tinfoil Dashboard](https://dash.tinfoil.sh) → **Containers** → **Deploy**
4. Select your repo and tag, then click **Deploy Container**

Once running, your container will respond at `https://<name>.<org>.containers.tinfoil.sh` with "Hello from a Tinfoil Container!"

## What's Inside

`tinfoil-config.yml` defines the deployment — the container image (pinned by SHA256 digest), ports, and exposed paths:

```yaml
containers:
  - name: "hello-world"
    image: "hashicorp/http-echo:latest@sha256:fcb75f69..."
    command: ["-listen=:8080", "-text=Hello from a Tinfoil Container!"]

shim:
  listen-port: 443
  upstream-port: 8080
  paths:
    - /*
```

## Next Steps

- Try changing the `-text` value in `tinfoil-config.yml`, push a new tag, and redeploy
- Deploy a real workload — here's a vLLM inference server as an example:
  ```yaml
  containers:
    - name: "inference"
      image: "vllm/vllm-openai:v0.14.1@sha256:6fc52be..."
      runtime: nvidia
      gpus: all
      ipc: host
      command: ["--model", "/models/my-model", "--port", "8001"]

  shim:
    listen-port: 443
    upstream-port: 8001
    paths:
      - /v1/chat/completions
      - /v1/responses
      - /health
  ```
- Start from the [template repo](https://github.com/tinfoilsh/tinfoil-containers-template) for your own deployments
- See the [full documentation](https://docs.tinfoil.sh/containers/overview) for configuration options, secrets, debug mode, and more
