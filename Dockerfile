FROM alpine:latest

ENV UUID=23ad6b10-8d1a-40f7-8ad0-e3e35cd38297 VER=4.10.0
COPY config.json /opt/v2ray/config.json

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip  \
 && unzip v2ray.zip -d /opt/v2ray \
 && chmod +x /opt/v2ray/v2ray \
 && chmod +x /opt/v2ray/v2ctl \
 && rm -rf v2ray.zip \
 && sed -i "s/23ad6b10-8d1a-40f7-8ad0-e3e35cd38297/${UUID}/g" "/etc/v2ray/config.json"

ENTRYPOINT /opt/v2ray/v2ray -config /opt/v2ray/

EXPOSE 8080

CMD ["/opt/v2ray/v2ray", "-config=/opt/v2ray/config.json"]