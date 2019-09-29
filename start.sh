#!/bin/sh
set -e

echo "UUID: ${UUID}"
sed -i "s/23ad6b10-8d1a-40f7-8ad0-e3e35cd38297/${UUID}/g" "/opt/v2ray/config.server.json"

exec "$@"
