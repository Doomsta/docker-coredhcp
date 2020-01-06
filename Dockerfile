FROM golang:1.13 AS build

RUN cd /tmp && git clone https://github.com/coredhcp/coredhcp.git \
  &&  cd coredhcp/cmds/coredhcp \                                                   
  && go build -ldflags "-linkmode external -extldflags -static" -a -o /coredhcp


FROM scratch
COPY --from=build /coredhcp /coredhcp
VOLUME /etc/coredhcpEXPOSE 67
CMD [ "/coredhcp" ]
