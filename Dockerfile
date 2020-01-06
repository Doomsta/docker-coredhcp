FROM golang:alpine AS build

RUN apk add --no-cache bash git openssh
RUN 
RUN cd /tmp git clone https://github.com/coredhcp/coredhcp.git \
  cd cmds/coredhcp && go build

FROM alpine:latest
RUN apk add --no-cache openssh 
COPY --from=build /tmp/cmds/coredhcp /usr/local/bin/coredhcp
RUN mkdir /working
WORKDIR /working
VOLUME /working
EXPOSE 67
CMD [ "/usr/local/bin/coredhcp" ]
