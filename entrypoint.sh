#!/bin/sh

envsubst </etc/syslog-ng/syslog-ng.conf.template > /etc/syslog-ng/syslog-ng.conf

if [ -n "$SYSLOG_DEBUG" ];
then
  syslog-ng -Fedv -f "$SYSLOG_CONF"
else
  if [ -n "$SYSLOG_AUTO_RESTART" ];
  then
    while true;
    do
      syslog-ng -F -f "$SYSLOG_CONF"
      sleep 10
    done    
  else
    syslog-ng -F -f "$SYSLOG_CONF"
  fi
fi
