FROM alpine:3.18.4
COPY update.sh /usr/local/bin/update.sh
RUN apk add --no-cache ca-certificates tzdata tini bash curl jq

USER nobody
ENTRYPOINT ["tini", "--", "update.sh"]
