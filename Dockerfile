FROM scratch
MAINTAINER Kevin Stock <kevinstock@tantalic.com>

ADD demo-linux-amd64 demo
ENV PORT 80
EXPOSE 80

ENTRYPOINT ["/demo"]

