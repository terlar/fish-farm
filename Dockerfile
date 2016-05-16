FROM debian:jessie
MAINTAINER Terje Larsen

ARG fish_repo=nightly:/master
ARG tank_version=master

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

WORKDIR /tmp
RUN echo "deb http://download.opensuse.org/repositories/shells:/fish:/$fish_repo/Debian_8.0/ /" >> /etc/apt/sources.list.d/fish.list \
	&& apt-get update && apt-get install -y --force-yes --no-install-recommends \
		fish \
		ca-certificates \
		curl \
		git \
		make \
		realpath \
		golang \
	&& go get github.com/motemen/ghq \
	&& curl -Lso source.tar.gz https://github.com/terlar/fish-tank/archive/$tank_version.tar.gz \
	&& tar -zxf source.tar.gz \
	&& cd fish-tank-$tank_version && make install \
	&& rm -rf /var/lib/apt/lists/*

COPY . /usr/src
WORKDIR /usr/src
RUN make install

CMD [ "fish" ]
