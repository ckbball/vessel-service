# vessel-service/Dockerfile
FROM golang:alpine as builder

RUN apk update && apk upgrade && apk add --no-cache git 

RUN mkdir /app
WORKDIR /app

ENV GO111MODULE=on

COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -0 shippy-service-vessel


FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /app//micro-tut/vessel-service .

CMD ["./vessel-service"]