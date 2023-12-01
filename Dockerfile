FROM alpine:3.18.5
COPY update.sh /usr/local/bin/update.sh
RUN apk add --no-cache ca-certificates tzdata tini curl jq

USER nobody
ENTRYPOINT ["tini", "--", "update.sh"]
