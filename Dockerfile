FROM centos:latest
MAINTAINER Jonathan Mainguy "jon@soh.re"

ENV ZNC_VERSION 1.6.1

RUN yum update -y \
    && yum install -y sudo wget make automake gcc gcc-c++ kernel-devel \
    tar openssl-devel perl-devel pkgconfig swig libicu-devel \
    && mkdir -p /src \
    && cd /src \
    && wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz" \
    && tar -zxf "znc-${ZNC_VERSION}.tar.gz" \
    && cd "znc-${ZNC_VERSION}" \
    && ./configure --disable-ipv6 \
    && make \
    && make install \
    && yum clean all \
    && rm -rf /src* /tmp/* /var/tmp/*

RUN useradd znc
ADD docker-entrypoint.sh /entrypoint.sh
ADD znc.conf.default /znc.conf.default
RUN chmod 644 /znc.conf.default

VOLUME /znc-data

EXPOSE 6667
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
