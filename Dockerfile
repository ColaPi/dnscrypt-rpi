FROM resin/raspberrypi3-alpine

MAINTAINER colachg <colachg@gmail.com>

ARG VERSION=2.0.17
ARG URL=https://github.com/jedisct1/dnscrypt-proxy/releases/download/$VERSION/dnscrypt-proxy-linux_arm-$VERSION.tar.gz

RUN set -ex &&\
    apk add --update --no-cache --virtual .build curl &&\
    curl -sSL $URL | tar xz --strip-components=1  -C /usr/local/bin/ linux-arm/dnscrypt-proxy &&\
    apk del --purge .build &&\
    rm -rf /var/cache/* /tmp/*

WORKDIR /dnscrypt
COPY dnscrypt-proxy.toml .

ENTRYPOINT ["/usr/local/bin/dnscrypt-proxy"]

CMD ["-config", "dnscrypt-proxy.toml"]