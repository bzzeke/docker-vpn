ARG arch=amd64
FROM ${arch}/alpine:latest

WORKDIR /app
VOLUME ["/app"]

USER root

ADD config /etc
RUN echo http://dl-cdn.alpinelinux.org/alpine/v3.6/main > /etc/apk/repositories;\
    echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories;\
    apk add --update iptables ip6tables sudo strongswan;\
    rm -rf /var/cache/apk/*
CMD ["/app/run.sh"]
