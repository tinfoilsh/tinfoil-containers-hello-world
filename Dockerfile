FROM golang:1.23-alpine AS build
WORKDIR /src
COPY go.mod ./
COPY main.go ./
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /hello-world .

FROM scratch
COPY --from=build /hello-world /hello-world
EXPOSE 8080
ENTRYPOINT ["/hello-world"]
