FROM ruby:alpine AS builder

RUN apk upgrade --no-cache && \
    apk add --no-cache curl && \
    curl -Ls http://www.lightirc.com/assets/policy/flashpolicyd.zip |unzip -q - && \
    cd flashpolicyd && \
    curl -Lso flashpolicyd.rb https://raw.github.com/ripienaar/flashpolicyd/master/flashpolicyd.rb && \
    chmod a+x flashpolicyd.rb


FROM ruby:alpine

MAINTAINER Jeremy T. Bouse <Jeremy.Bouse@UnderGrid.net>

RUN apk upgrade --no-cache && \
    apk add --no-cache tini

COPY --from=builder /flashpolicyd /flashpolicyd

WORKDIR /flashpolicyd

ENV PORT 843

EXPOSE ${PORT}

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ruby", "./flashpolicyd.rb", "--xml", "flashpolicy.xml", "--logfile", "flashpolicyd.log", "--no-daemonize"]
