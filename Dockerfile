FROM golang:1.21-alpine as builder

WORKDIR /app

COPY . .

RUN go mod init app.go

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o app

FROM scratch

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]
