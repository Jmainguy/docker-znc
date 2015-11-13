#!/bin/bash
if [ ! -d /opt/znc ]; then
  mkdir -p /opt/znc
fi
docker run -td -p 6667 -v /opt/znc/:/znc-data:Z sohre/znc
