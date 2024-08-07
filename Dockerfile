# syntax=docker/dockerfile:labs
FROM alpine:3.20.2
COPY --from=zoeyvid/curl-quic:408 /usr/local/bin/curl /usr/local/bin/curl
COPY update.sh /usr/local/bin/update.sh
RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates tzdata tini jq

USER nobody
ENTRYPOINT ["tini", "--", "update.sh"]
