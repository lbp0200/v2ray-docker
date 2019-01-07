FROM alpine:latest

ENV UUID=23ad6b10-8d1a-40f7-8ad0-e3e35cd38297 VER=4.10.0

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && echo https://github.com/v2ray/v2ray-core/releases/download/v${VER}/v2ray-linux-64.zip \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v${VER}/v2ray-linux-64.zip \
 && mkdir -p /opt/v2ray \
 && unzip v2ray.zip -d /opt/v2ray \
 && chmod +x /opt/v2ray/v2ray \
 && chmod +x /opt/v2ray/v2ctl \
 && rm -rf v2ray.zip 

COPY config.json /opt/v2ray/config.server.json

RUN sed -i "s/23ad6b10-8d1a-40f7-8ad0-e3e35cd38297/${UUID}/g" "/opt/v2ray/config.server.json"

# ENTRYPOINT /opt/v2ray/v2ray -config /opt/v2ray/

EXPOSE 80

CMD ["/opt/v2ray/v2ray", "-config", "/opt/v2ray/config.server.json"]