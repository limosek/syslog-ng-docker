FROM debian:trixie

# Instalace závislostí
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive \
         apt-get install -y --no-install-recommends \
            syslog-ng ca-certificates psmisc iproute2 procps gettext-base \
            -o Dpkg::Options::="--force-confdef" \
            -o Dpkg::Options::="--force-confold"

# If set to non-empty, restart syslog-ng on error forever
ENV SYSLOG_AUTO_RESTART=""

# Syslog config file location
ENV SYSLOG_CONF=/etc/syslog-ng/syslog-ng.conf

# Set to non-empty for full debugging
ENV SYSLOG_DEBUG=""

# This variable will be added to SDATA META
ENV SDATA_VARIABLE="SOURCE_ID"

# This will be default source_id for all messages
ENV SOURCE_ID="all"

# Maximum EPS. All logs with higher rate will be discarded
ENV MAX_EPS=100

VOLUME /var/log/syslog-ng

ENTRYPOINT /entrypoint.sh

COPY entrypoint.sh /
COPY syslog-ng.conf.template /etc/syslog-ng/

RUN chmod +x /entrypoint.sh
