FROM golang:1.21.4-alpine3.18 AS gobuilder

RUN mkdir /eneyene.github.io
WORKDIR /eneyene.github.io

COPY main/go.mod main/go.sum ./
RUN go version
RUN go mod download

COPY main .
RUN go build -o eneyene.github.io.go

FROM alpine:3.18.4

RUN mkdir /eneyene.github.io
WORKDIR /eneyene.github.io

COPY --from=gobuilder /eneyene.github.io/eneyene.github.io.go ./
COPY frontend ./frontend

EXPOSE 8080
CMD /eneyene.github.io/eneyene.github.io.go