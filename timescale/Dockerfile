# Getting the arguement before the build
ARG TAG

FROM timescale/timescaledb:${TAG}

# Getting timescale compatibility library from 1.5.0 ~ 1.7.1 library
COPY timescale/timescale.tar.gz /tmp
RUN tar xf /tmp/timescale.tar.gz -C /tmp

# copying libraries dependencies
RUN cp -R -u /tmp/postgresql /usr/local/lib/postgresql
