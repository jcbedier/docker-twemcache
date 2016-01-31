FROM debian
MAINTAINER jcbedier "http://github.com/jcbedier/"
ENV TWEMBALL twemcache-2.5.2.tar.gz
ENV REPOS https://github.com/downloads/twitter/twemcache
ENV MAXMEM 64
RUN apt-get update
RUN apt-get install -y make gcc wget libevent-dev ca-certificates
RUN wget -k $REPOS/$TWEMBALL -O /tmp/twemcache.tar.gz
RUN (cd /tmp && tar zxf twemcache.tar.gz && cd twemcache-* && ./configure --prefix=/usr/local/twemcache && make && make install)
RUN rm -rf /tmp/*
RUN groupadd twem
RUN useradd twem -g twem
RUN apt-get clean
EXPOSE 11211
ENTRYPOINT ["/usr/local/twemcache/bin/twemcache"]
CMD ["-u", "twem", "-m", $MAXMEM]
