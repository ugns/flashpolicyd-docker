FROM ruby:alpine

MAINTAINER Jeremy T. Bouse <Jeremy.Bouse@UnderGrid.net>

RUN apk upgrade --no-cache && \
    apk add --no-cache tini && \
    gem install flash_policy_server --no-rdoc --no-ri

WORKDIR /flashpolicyd

COPY flashpolicyd .
COPY crossdomain.xml .

ENV PORT 843

EXPOSE ${PORT}

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["./flashpolicyd"]
