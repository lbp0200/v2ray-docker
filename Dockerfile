FROM alpine:latest

ENV UUID=23ad6b10-8d1a-40f7-8ad0-e3e35cd38297 VER=4.20.0

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && echo https://github.com/v2ray/v2ray-core/releases/download/v${VER}/v2ray-linux-64.zip \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v${VER}/v2ray-linux-64.zip \
 && mkdir -p /opt/v2ray \
 && unzip v2ray.zip -d /opt/v2ray \
 && chmod +x /opt/v2ray/v2ray \
 && chmod +x /opt/v2ray/v2ctl \
 && rm -rf v2ray.zip 

COPY start.sh /opt/v2ray/
COPY config.json /opt/v2ray/config.server.json

EXPOSE 80

ENTRYPOINT ["/opt/v2ray/start.sh"]

CMD ["/opt/v2ray/v2ray", "-config", "/opt/v2ray/config.server.json"]
