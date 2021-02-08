FROM nlss/base-alpine

ENV WEB_ROOT html

# 82 is the standard uid/gid for "www-data" in Alpine
RUN set -eux \
    && apk add --update --upgrade --no-cache nginx tzdata \
    && addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data \
	&& mkdir -p /var/www/html \
	&& wget -O /usr/local/bin/attr https://gist.githubusercontent.com/xZero707/7a3fb3e12e7192c96dbc60d45b3dc91d/raw/f3e905e2f6c4b9496904c8251b51fbab99c600df/attr.sh \
    && chmod a+x /usr/local/bin/attr

# Install gomplate
COPY --from=hairyhenderson/gomplate:v3.6.0-slim /gomplate  /usr/bin/gomplate

ADD rootfs /

EXPOSE 80/TCP