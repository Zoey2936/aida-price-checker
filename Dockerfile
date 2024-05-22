# syntax=docker/dockerfile:labs
FROM alpine:3.20.0
COPY update.sh /usr/local/bin/update.sh
RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates tzdata tini curl jq

USER nobody
ENTRYPOINT ["tini", "--", "update.sh"]
