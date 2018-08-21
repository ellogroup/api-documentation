FROM golang:1.9-alpine as build

RUN apk update && apk add ca-certificates && update-ca-certificates && apk add --virtual build-deps git && apk add openssl
RUN go get -u github.com/tomnomnom/gron

COPY . /opt/swagger
WORKDIR /opt/swagger

CMD /opt/swagger/scripts/get-latest.sh
