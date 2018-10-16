FROM alpine

MAINTAINER Jeremy T. Bouse <Jeremy.Bouse@UnderGrid.net>

RUN apk upgrade --no-cache && \
    apk add --no-cache python2 tini

WORKDIR /flashpolicyd

COPY flashpolicyd .
COPY crossdomain.xml .

ENV PORT 843

EXPOSE ${PORT}

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["./flashpolicyd","--port=843","--file=crossdomain.xml"]
