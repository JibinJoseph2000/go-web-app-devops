FROM golang:1.24.13 AS base

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o main .

#Final image

FROM gcr.io/distroless/cc-debian12

# COPY --from=base /app/main /

# COPY --from=base /app/static ./static

WORKDIR /app

COPY --from=base --chown=nonroot:nonroot /app/main /app/main
COPY --from=base --chown=nonroot:nonroot /app/static /app/static



USER nonroot:nonroot

EXPOSE 8080

CMD ["./main"]
