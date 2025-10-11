FROM debian:trixie

# Instalace závislostí
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive \
         apt-get install -y --no-install-recommends \
            syslog-ng ca-certificates psmisc iproute2 procps \
            -o Dpkg::Options::="--force-confdef" \
            -o Dpkg::Options::="--force-confold"
 
VOLUME /var/log/syslog-ng

ENTRYPOINT /entrypoint.sh

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh



