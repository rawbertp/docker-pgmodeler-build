FROM debian:stretch-slim

ENV PG_VERSION 0.9.2-alpha1
ENV DEST /out

RUN mkdir -p ${DEST}

ADD https://codeload.github.com/pgmodeler/pgmodeler/tar.gz/v${PG_VERSION} /usr/local/src/
WORKDIR /usr/local/src/

RUN if [ ! -d pgmodeler-${PG_VERSION} ]; then tar xvzf v${PG_VERSION}; fi \
  && cd pgmodeler-${PG_VERSION} \
  && BUILD_PKGS="make g++ qt5-qmake libxml2-dev \
    libpq-dev pkg-config libqt5svg5-dev" \
  && RUNTIME_PKGS="qt5-default libqt5svg5 postgresql-server-dev-9.6" \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
     apt-get -y install ${BUILD_PKGS} ${RUNTIME_PKGS} \
  && qmake PREFIX=${DEST} pgmodeler.pro \
  && make && make install \
  && cd .. \
  && apt-get remove --purge -y $BUILD_PKGS \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p ${DEST}/lib/pgmodeler/plugins \
  && chmod 777 ${DEST}/lib/pgmodeler/plugins

ENTRYPOINT ["/bin/bash"]
