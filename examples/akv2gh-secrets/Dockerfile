ARG GO_VERSION=1.18

# Build container
FROM docker.io/golang:${GO_VERSION}-alpine AS build

RUN apk add --no-cache git zip

WORKDIR /src

# Fetch dependencies
COPY ./go.mod ./go.sum ./
RUN go mod download

COPY ./ ./

# Build static binary
RUN CGO_ENABLED=0 go build -installsuffix 'static' -o /akv2gh ./cmd/akv2gh

# Final container
FROM gcr.io/distroless/static AS final

USER nonroot:nonroot

COPY --from=build --chown=nonroot:nonroot /akv2gh /akv2gh

ENTRYPOINT ["/akv2gh"]
