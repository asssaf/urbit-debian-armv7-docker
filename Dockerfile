FROM arm32v7/debian:jessie as builder
RUN apt-get update
RUN apt-get -y install libgmp3-dev libsigsegv-dev openssl libssl-dev libncurses5-dev make \
  exuberant-ctags automake autoconf libtool g++ ragel cmake re2c libcurl4-gnutls-dev curl \
  zlib1g-dev patch

ENV PV=0.4.5
RUN curl -L https://github.com/urbit/urbit/archive/v${PV}.tar.gz | tar xz

# apply patches
ADD /*.patch /
RUN cat /*.patch | patch -Np0

RUN mv /urbit-${PV} /urbit
WORKDIR /urbit

RUN make


FROM arm32v7/debian:jessie

COPY --from=builder /urbit/bin/urbit /usr/local/bin/

RUN apt-get update \
	&& apt-get -y install openssl libsigsegv2 libgmp10 libcurl3-gnutls \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /

WORKDIR /urbit
ENTRYPOINT [ "/entrypoint.sh" ]
