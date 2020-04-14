FROM nlss/base-alpine

ENV WEB_ROOT html

# 82 is the standard uid/gid for "www-data" in Alpine
RUN set -eux \
    && apk add --update --upgrade --no-cache nginx tzdata \
    && addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data \
	&& mkdir -p /var/www/html

# Install gomplate
COPY --from=hairyhenderson/gomplate:v3.6.0-slim /gomplate  /usr/bin/gomplate

ADD rootfs /

EXPOSE 80/TCP