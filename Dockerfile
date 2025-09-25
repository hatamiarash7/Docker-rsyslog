FROM alpine:3.22.1

ARG DATE_CREATED
ARG APP_VERSION

LABEL maintainer="Arash Hatami <hatamiarash7@gmail.com>"
LABEL org.opencontainers.image.created=$DATE_CREATED
LABEL org.opencontainers.version="$APP_VERSION"
LABEL org.opencontainers.image.authors="hatamiarash7"
LABEL org.opencontainers.image.vendor="hatamiarash7"
LABEL org.opencontainers.image.title="rsyslog"
LABEL org.opencontainers.image.description="Deploy rsyslog using Docker"
LABEL org.opencontainers.image.source="https://github.com/hatamiarash7/docker-rsyslog"

RUN apk add --no-cache bash rsyslog

COPY rsyslog.conf /etc/rsyslog.conf

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 514

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rsyslogd", "-n"]