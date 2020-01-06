FROM golang:alpine AS build

RUN apk add --no-cache bash git openssh

RUN cd /tmp && git clone https://github.com/coredhcp/coredhcp.git \
  &&  cd coredhcp/cmds/coredhcp && go build

FROM alpine:latest
RUN apk add --no-cache openssh
COPY --from=build /tmp/coredhcp/cmds/coredhcp/coredhcp /usr/local/bin/coredhcp
VOLUME /etc/coredhcp
EXPOSE 67
CMD [ "/usr/local/bin/coredhcp" ]
