FROM golang:1.9-alpine as build

RUN apk add --virtual build-deps git
RUN go get -u github.com/tomnomnom/gron

COPY . /opt/swagger
WORKDIR /opt/swagger

CMD /opt/swagger/scripts/get-latest.sh
