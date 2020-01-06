FROM golang:alpine AS build

RUN apk add --no-cache git
RUN cd /tmp && git clone https://github.com/coredhcp/coredhcp.git \
  &&  cd coredhcp/cmds/coredhcp \
  && go build -o /coredhcp


FROM golang:alpine
COPY --from=build /coredhcp /coredhcp
VOLUME /etc/coredhcp
EXPOSE 67
CMD [ "/coredhcp" ]
